class QuizzesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :publish, :take_quiz, :results]
  after_action :verify_authorized, except: [:index, :take_quiz, :results]

  def index
    @quizzes = policy_scope(Quiz).includes(:admin, :questions).order(created_at: :desc)
  end

  def show
    authorize @quiz
    @questions = @quiz.questions.includes(:options).order(:created_at)
  end

  def new
    @quiz = Quiz.new
    authorize @quiz
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.admin = current_admin
    authorize @quiz

    if @quiz.save
      redirect_to @quiz, notice: 'Quiz criado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @quiz
  end

  def update
    authorize @quiz
    if @quiz.update(quiz_params)
      redirect_to @quiz, notice: 'Quiz atualizado com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @quiz
    @quiz.destroy
    redirect_to quizzes_path, notice: 'Quiz excluído com sucesso!'
  end

  def publish
    authorize @quiz
    if @quiz.update(status: 'published')
      redirect_to @quiz, notice: 'Quiz publicado com sucesso!'
    else
      redirect_to @quiz, alert: 'Erro ao publicar quiz.'
    end
  end

  def take_quiz
    unless @quiz.can_be_taken_by?(current_admin)
      redirect_to quizzes_path, alert: 'Você não pode fazer este quiz.'
      return
    end
    
    @questions = @quiz.questions.includes(:options).order(:created_at)
    @current_question = @questions.first
    @user_answers = current_admin.answers.where(quiz: @quiz).index_by(&:question_id)
  end

  def results
    unless @quiz.user_has_answered?(current_admin) || current_admin.admin? || current_admin.moderator?
      redirect_to quizzes_path, alert: 'Você não respondeu este quiz.'
      return
    end
    
    @user_answers = current_admin.answers.where(quiz: @quiz).includes(:option, :question)
    @score = @quiz.user_score(current_admin)
    @percentage = @quiz.user_percentage(current_admin)
    @total_points = @quiz.total_points
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description, :status)
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_quiz
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index]

  def index
    @questions = policy_scope(Question).where(quiz: @quiz).includes(:options).order(:created_at)
  end

  def show
    authorize @question
  end

  def new
    @question = @quiz.questions.build
    @question.options.build
    authorize @question
  end

  def create
    @question = @quiz.questions.build(question_params)
    authorize @question

    if @question.save
      redirect_to quiz_path(@quiz), notice: 'Pergunta criada com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @question
    @question.options.build if @question.options.empty?
  end

  def update
    authorize @question
    if @question.update(question_params)
      redirect_to quiz_path(@quiz), notice: 'Pergunta atualizada com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to quiz_path(@quiz), notice: 'Pergunta excluída com sucesso!'
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :question_text, 
      :question_type, 
      :points,
      options_attributes: [:id, :option_text, :is_correct, :_destroy]
    )
  end
end

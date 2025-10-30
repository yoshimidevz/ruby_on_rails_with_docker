class AnswersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_quiz
  before_action :set_question
  before_action :set_answer, only: [:update, :destroy]
  after_action :verify_authorized

  def create
    # Remove resposta anterior se existir
    existing_answer = current_admin.answers.find_by(question: @question)
    existing_answer&.destroy

    @answer = current_admin.answers.build(answer_params)
    @answer.quiz = @quiz
    @answer.question = @question
    authorize @answer

    if @answer.save
      next_question = @quiz.questions.where('id > ?', @question.id).first
      if next_question
        redirect_to take_quiz_quiz_path(@quiz, question: next_question.id), notice: 'Resposta salva!'
      else
        redirect_to results_quiz_path(@quiz), notice: 'Quiz concluído!'
      end
    else
      redirect_to take_quiz_quiz_path(@quiz), alert: 'Erro ao salvar resposta.'
    end
  end

  def update
    authorize @answer
    if @answer.update(answer_params)
      redirect_to take_quiz_quiz_path(@quiz), notice: 'Resposta atualizada!'
    else
      redirect_to take_quiz_quiz_path(@quiz), alert: 'Erro ao atualizar resposta.'
    end
  end

  def destroy
    authorize @answer
    @answer.destroy
    redirect_to take_quiz_quiz_path(@quiz), notice: 'Resposta removida!'
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find(params[:question_id])
  end

  def set_answer
    @answer = current_admin.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:option_id)
  end
end

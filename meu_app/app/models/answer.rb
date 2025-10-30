class Answer < ApplicationRecord
  # Associações
  belongs_to :admin
  belongs_to :question
  belongs_to :option
  belongs_to :quiz
  
  # Validações
  validates :admin_id, uniqueness: { scope: :question_id, message: 'já respondeu esta pergunta' }
  validate :option_belongs_to_question
  validate :question_belongs_to_quiz
  
  # Scopes
  scope :by_user, ->(user) { where(admin: user) }
  scope :by_quiz, ->(quiz) { where(quiz: quiz) }
  scope :correct, -> { joins(:option).where(options: { is_correct: true }) }
  scope :incorrect, -> { joins(:option).where(options: { is_correct: false }) }
  
  # Métodos
  def correct?
    option.is_correct?
  end
  
  def incorrect?
    !correct?
  end
  
  def points_earned
    correct? ? question.points : 0
  end
  
  # Métodos de classe
  def self.user_quiz_score(user, quiz)
    where(admin: user, quiz: quiz)
      .joins(:question)
      .joins(:option)
      .where(options: { is_correct: true })
      .sum('questions.points')
  end
  
  def self.user_quiz_percentage(user, quiz)
    total_points = quiz.total_points
    return 0 if total_points.zero?
    
    score = user_quiz_score(user, quiz)
    (score.to_f / total_points * 100).round(2)
  end
  
  private
  
  def option_belongs_to_question
    return unless option && question
    return if option.question == question
    
    errors.add(:option, 'deve pertencer à pergunta selecionada')
  end
  
  def question_belongs_to_quiz
    return unless question && quiz
    return if question.quiz == quiz
    
    errors.add(:question, 'deve pertencer ao quiz selecionado')
  end
end


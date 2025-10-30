class Question < ApplicationRecord
  # Associações
  belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  accepts_nested_attributes_for :options, allow_destroy: true
  
  # Validações
  validates :question_text, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :question_type, presence: true, inclusion: { in: %w[multiple_choice true_false] }
  validates :points, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  
  # Enums
  enum :question_type, { multiple_choice: 'multiple_choice', true_false: 'true_false' }
  
  # Validações customizadas
  validate :has_correct_option
  validate :has_minimum_options
  
  # Scopes
  scope :by_quiz, ->(quiz) { where(quiz: quiz) }
  
  # Métodos
  def correct_options
    options.where(is_correct: true)
  end
  
  def correct_option
    correct_options.first
  end
  
  def has_correct_answer?
    correct_options.exists?
  end
  
  def user_answer(user)
    answers.find_by(admin: user)
  end
  
  def user_answered_correctly?(user)
    user_answer = user_answer(user)
    return false unless user_answer
    user_answer.option.is_correct?
  end
  
  private
  
  def has_correct_option
    return if options.empty?
    errors.add(:options, 'deve ter pelo menos uma opção correta') unless has_correct_answer?
  end
  
  def has_minimum_options
    return if options.empty?
    min_options = multiple_choice? ? 2 : 2
    errors.add(:options, "deve ter pelo menos #{min_options} opções") if options.count < min_options
  end
end

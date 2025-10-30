class Option < ApplicationRecord
  # Associações
  belongs_to :question
  has_many :answers, dependent: :destroy
  
  # Validações
  validates :option_text, presence: true, length: { minimum: 1, maximum: 500 }
  validates :is_correct, inclusion: { in: [true, false] }
  
  # Validações customizadas
  validate :only_one_correct_for_true_false
  
  # Scopes
  scope :correct, -> { where(is_correct: true) }
  scope :incorrect, -> { where(is_correct: false) }
  scope :by_question, ->(question) { where(question: question) }
  
  # Métodos
  def correct?
    is_correct?
  end
  
  def incorrect?
    !is_correct?
  end
  
  def selected_by_user?(user)
    answers.exists?(admin: user)
  end
  
  private
  
  def only_one_correct_for_true_false
    return unless question&.true_false?
    return unless is_correct?
    
    other_correct_options = question.options.where.not(id: id).where(is_correct: true)
    if other_correct_options.exists?
      errors.add(:is_correct, 'apenas uma opção pode ser correta em perguntas verdadeiro/falso')
    end
  end
end


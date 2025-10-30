class Quiz < ApplicationRecord
  # Associações
  belongs_to :admin
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  # Validações
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, presence: true, inclusion: { in: %w[draft published closed] }
  
  # Enums
  enum :status, { draft: 'draft', published: 'published', closed: 'closed' }
  
  # Scopes
  scope :published, -> { where(status: 'published') }
  scope :by_admin, ->(admin) { where(admin: admin) }
  scope :available_for_student, -> { published }
  
  # Métodos
  def total_points
    questions.sum(:points)
  end
  
  def total_questions
    questions.count
  end
  
  def can_be_taken_by?(user)
    return false unless user.present?
    return true if user.admin? || user.moderator?
    published? && !user_has_answered?(user)
  end
  
  def user_has_answered?(user)
    answers.exists?(admin: user)
  end
  
  def user_score(user)
    return 0 unless user_has_answered?(user)
    
    user_answers = answers.where(admin: user)
    correct_answers = user_answers.joins(:option).where(options: { is_correct: true })
    correct_answers.joins(:question).sum('questions.points')
  end
  
  def user_percentage(user)
    return 0 if total_points.zero?
    (user_score(user).to_f / total_points * 100).round(2)
  end
end

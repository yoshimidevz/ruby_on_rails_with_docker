class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Enums para roles
  enum :role, { student: 'student', moderator: 'moderator', admin: 'admin' }
  
  # Validações
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }
  
  # Associações
  has_many :quizzes, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  # Callbacks
  after_create :send_welcome_email
  
  # Métodos de verificação de role
  def admin?
    role == 'admin'
  end
  
  def moderator?
    role == 'moderator'
  end
  
  def student?
    role == 'student'
  end
  
  def can_manage_quizzes?
    admin? || moderator?
  end
  
  def can_view_all_quizzes?
    admin? || moderator?
  end

  private 
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end

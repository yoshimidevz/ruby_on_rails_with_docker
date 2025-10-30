class QuestionPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    return true if user.admin? || user.moderator?
    record.quiz.published?
  end

  def create?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.quiz.admin == user
  end

  def new?
    create?
  end

  def update?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.quiz.admin == user
  end

  def edit?
    update?
  end

  def destroy?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.quiz.admin == user
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.joins(:quiz).where(quizzes: { status: 'published' })
      end
    end
  end
end


class AnswerPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    return true if user.admin? || user.moderator?
    record.admin == user
  end

  def create?
    return false unless user.present?
    return true if user.admin? || user.moderator?
    record.quiz.can_be_taken_by?(user)
  end

  def new?
    create?
  end

  def update?
    return false unless user.present?
    return true if user.admin? || user.moderator?
    record.admin == user && record.created_at > 1.hour.ago
  end

  def edit?
    update?
  end

  def destroy?
    return false unless user.present?
    return true if user.admin?
    record.admin == user && record.created_at > 1.hour.ago
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.where(admin: user)
      end
    end
  end
end


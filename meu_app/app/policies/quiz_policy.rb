class QuizPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    return true if user.admin? || user.moderator?
    record.published? && !record.user_has_answered?(user)
  end

  def create?
    user.present? && user.can_manage_quizzes?
  end

  def new?
    create?
  end

  def update?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.admin == user
  end

  def edit?
    update?
  end

  def destroy?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.admin == user
  end

  def publish?
    return false unless user.present?
    return true if user.admin?
    user.moderator? && record.admin == user
  end

  def take_quiz?
    return false unless user.present?
    return true if user.admin? || user.moderator?
    record.can_be_taken_by?(user)
  end

  def view_results?
    return false unless user.present?
    return true if user.admin? || user.moderator?
    record.user_has_answered?(user)
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.published
      end
    end
  end
end


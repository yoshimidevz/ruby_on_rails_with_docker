class PostPolicy < ApplicationPolicy

  def index?
    true # qualquer usuário pode listar posts
  end
 
  def show?
    true # qualquer usuário pode ver um post
  end

  def create?
    user.present? # apenas usuários logados podem criar
  end

  def new?
    create?
  end
  
  def update?
  #  user.present? && record.user_id == user.id # só o dono do post
    true
  end

  def edit?
    update?
  end
  
  def destroy?
    user.present? && user.admin? || record.user_id == user.id # só o dono do post ou admin
  end

  # class Scope < A

end

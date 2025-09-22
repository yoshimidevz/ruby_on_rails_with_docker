class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  allow_browser versions: :modern

  include Pundit

  rescue from Pundit::NotAuthorizedError, with: :user_not_authorized
  private
  def user_not_authorized
    flash[:alert] = "Você não está autorizado a realizar esta ação."
    redirect_to(request.referrer || root_path)
  end
  
end

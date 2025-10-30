class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private
  def user_not_authorized
    flash[:alert] = "Você não está autorizado a realizar esta ação."
    redirect_to(request.referrer || root_path)
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # Faz o Pundit usar o admin autenticado em vez de current_user
  def pundit_user
    current_admin
  end
  
end

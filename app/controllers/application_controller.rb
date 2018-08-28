class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter "save_my_previous_url", only: [:new]

  protected

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end

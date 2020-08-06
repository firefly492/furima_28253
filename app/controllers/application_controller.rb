class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '1111'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up){|u| 
      u.permit(:nickname, :email, :password, :password_confirmation, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date)}
  end
end

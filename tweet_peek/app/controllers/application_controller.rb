class ApplicationController < ActionController::Base

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
  # end
  protect_from_forgery
end

class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_or_initialize_by(uuid: session[:uuid]) if session[:uuid].present?
    @current_user&.save unless @current_user&.persisted?
    @current_user
  end

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?
  helper_method :current_user
end

class ApplicationController < ActionController::Base
  around_action :set_time_zone

  def current_user
    @current_user ||= User.find_or_initialize_by(uuid: session[:uuid]) if session[:uuid].present?
    @current_user&.save unless @current_user&.persisted?
    @current_user
  end

  def logged_in?
    current_user.present?
  end

  def current_time_zone
    current_user&.time_zone || "Mountain Time (US & Canada)"
  end

  def datetime_string(datetime)
    "#{ datetime.strftime("%A %b %e at %l %p") }, #{current_time_zone}"
  end

  def set_time_zone(&block)
    Time.use_zone(current_time_zone, &block)
  end

  helper_method :logged_in?
  helper_method :current_user
  helper_method :datetime_string
end

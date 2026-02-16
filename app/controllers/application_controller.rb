class ApplicationController < ActionController::Base
  before_action :authorize

  helper_method :current_user

  private

  def authorize
    unless current_user
      redirect_to login_path, alert: "Please log in."
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allows following methods to be available to Views
  helper_method :current_user, :logged_in?, :admin?

  def admin?
    !!current_user.admin if current_user
  end

  def require_user
    if !user_signed_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_back(fallback_location: root_path)
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  private
  def configure_permitted_parameters
      attributes = [:username]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end
end

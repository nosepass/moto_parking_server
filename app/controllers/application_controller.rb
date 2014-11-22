class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #skip_before_action :verify_authenticity_token

  def require_auth
    if session[:user_id]
      return true 
    else
      render json: {message: "not authenticated"}, status: :forbidden
      return false
    end
  end

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end

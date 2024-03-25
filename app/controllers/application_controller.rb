class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :is_admin?
  
    def current_user
      @current_user ||= Employee.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
  
    def is_admin?
      current_user && current_user.role == "admin"
    end
  
    def must_login
      unless logged_in?
        flash[:alert] = "Please log in!"
        redirect_to login_path
      end
    end
  end
  
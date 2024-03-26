class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :is_admin?, :must_login
    rescue_from StandardError, with: :handle_exception
    
    def current_user
      @current_user ||= Employee.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
  
    def is_admin?
      current_user && current_user.role == "admin"
    end
  
    def must_login1
      unless logged_in?
        flash[:alert] = "Please log in!"
        redirect_to login_path
        return false
      end
      true
    end   
    
    def must_login2
      unless is_admin?
        flash[:alert] = "Please log in with admin!"
        redirect_to login_path
        return false
      end
      true
    end
    
    def page_not_found
      redirect_to '/404'
    end

    def handle_exception(exception)
      redirect_to '/500'
    end
  end
  
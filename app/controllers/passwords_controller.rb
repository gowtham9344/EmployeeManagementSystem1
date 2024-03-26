class PasswordsController < ApplicationController
    before_action :must_login1
  
    def edit
    end
  
    def update
      if current_user.update(password_params)
        redirect_to employees_path
      else
        render 'edit'  
      end
    end
  
    private
  
    def password_params
      params.require(:employee).permit(:password, :password_confirmation)
    end
  end
  
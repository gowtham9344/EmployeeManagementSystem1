class SessionsController < ApplicationController
  def new
  end

  def create
    user = Employee.find_by(email: params[:email])
  
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have signed in'
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render 'new'
    end
  end
  
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Good bye"
    redirect_to root_path
  end 
end
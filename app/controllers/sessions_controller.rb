class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully signed in!"
      redirect_to "/#{user.id}"
    else
      flash.now[:danger] = "Username and password combination incorrect"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end

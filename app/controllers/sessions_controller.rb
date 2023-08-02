class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    user = User.authenticate_with_credentials(email, password)

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end

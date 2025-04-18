class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id

      flash[:notice] = "Login Successful!"
      redirect_to user
    else
      flash.now[:alert] = "Invalid Credentials!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:notice] = "Account already logged in."
      redirect_to current_user
    end
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :restrict_redirect_signup, only: [:new, :create]

  def show
    # expects show.html.erb file under views section
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def new
    # expects new.html.erb file under views section
    @user = User.new
  end

  def edit
    # expects edit.html.erb file under views section
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information has been updated successfully."
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # creating login session as soon as the new user sign ups
      flash[:notice] = "Welcome to  the Beta Blogs, " + @user.username << "!\nYour account has been created successfully. Enjoy Seamless Blogging Experience :)"
      redirect_to @user # for now...
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if current_user.admin?
      flash[:notice] = "Account deleted successfully!"
      redirect_to @user
    else
      flash[:notice] = "Your account has been deleted successfully. We are sorry to see you at this stage and hope you will come back again :)"
      redirect_to root_path
    end
    session[:user_id] = nil if @user == current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only perform this action on your own account."
      redirect_to @user
    end
  end

  def restrict_redirect_signup
    if logged_in?
      flash[:warning] = "You need to logout from the system before performing this action."
      redirect_to current_user
    end
  end
end

class UsersController < ApplicationController
  def new
    # expects new.html.erb file under views section
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      flash[:notice] = "Welcome to  the Beta Blogs, " + @user.username << "! Your account has been created successyfully. Enjoy Blogging :)"
      redirect_to articles_path # for now...
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end

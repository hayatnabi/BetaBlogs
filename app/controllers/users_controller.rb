class UsersController < ApplicationController
  def new
    # expects new.html.erb file under views section
    @user = User.new
  end

  def create
  end
end

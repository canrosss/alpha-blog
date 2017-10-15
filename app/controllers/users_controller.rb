class UsersController < ApplicationController
  def new(*args)
    @user = User.new

  end

  def create(*args)
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
  def user_params(*args)
    params.require(:user).permit(:username, :email, :password)
  end
end

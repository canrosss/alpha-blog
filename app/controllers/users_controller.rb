class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only[:edit, :update]

  def index(*args)
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

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

  def edit(*args)
  end



  def show(*args)
     @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def update(*args)
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  end

  private
  def user_params(*args)
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user(*args)
    @user = User.find(params[:id])
  end

  def require_same_user(*args)
    if current_user!=@user
      flash[:danger] = "You can only edit your own account"
      redirect_path
    end
  end
end

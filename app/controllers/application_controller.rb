class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user(*args)
    #busca el id del user para traerse datos de db
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #Si no tengo user retorna falso
    !!current_user

  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end

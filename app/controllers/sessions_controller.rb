class SessionsController < ApplicationController
  def new(*args)

  end

  def create(*args)
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #Si el user esta logeado user_id tiene algo
      session[:user_id] = user.id
      flash[:success] = "You have successfully login"
      redirect_to users_path(user)
    else
      #Permanece durante una session activa
      flash.now[:danger] = "There was something wrong with ur login information"
      #Si falla queremos renderizar new para que reintente.
      render 'new'
    end
  end

  def destroy(*args)
    session[:user_id] = nil
    flash[:success] = "You have logged out "
    redirect_to root_path

  end
end

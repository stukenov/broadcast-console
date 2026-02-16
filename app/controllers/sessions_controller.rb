require 'bcrypt'

class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end
  
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Вход выполнен успешно."
    else
      flash.now[:alert] = "Неверные имя пользователя или пароль."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Вы успешно вышли."
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end 
class UsersController < ApplicationController
  before_action :authorize, except: [:new, :create]
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    # Ensure @user is set by the before_action
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "User created successfully."
    else
      flash.now[:alert] = "Failed to create user."
      render :new
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "User deleted successfully."
    else
      redirect_to users_path, alert: "Failed to delete user."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path, alert: "User not found."
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

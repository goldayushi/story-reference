class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :not_admin_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  def show
    redirect_to users_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path
    else
      render 'index'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :admin)
    end
end

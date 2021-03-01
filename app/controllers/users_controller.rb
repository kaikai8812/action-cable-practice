class UsersController < ApplicationController
  before_action :authenticate_user, { only: [:index, :show, :edit, :update] }
  before_action :check_user, { only: [:edit, :update] }
  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def follows
    @user = User.find(params[:id])
    @users = @user.followings
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followeds
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

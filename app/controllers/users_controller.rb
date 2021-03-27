class UsersController < ApplicationController

  def new


  end

  def create

  end

  def index
    @user = current_user
    @user = User.all

  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end

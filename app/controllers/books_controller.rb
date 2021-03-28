class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:succes] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render action: :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @booknew = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end
end

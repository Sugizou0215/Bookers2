class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_book,only: [:edit,:update,:destroy] #直打ちによるedit,update,destroyの禁止

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user #ログインユーザのidを取得
    @book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    user_id = Book.find(params[:id]).user_id
    @user = User.find(user_id) #投稿したユーザのidを取得
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  # ストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  #直打ちによるedit,update,destroyがされた場合の遷移先指定
  def correct_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order

    @user_books = @user.books
    @today_book = @user_books.created_today
    @yesterday_book = @books.created_yesterday
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def index
    @user = current_user #ログインユーザのidを取得
    @book = Book.new
    @users = User.all
  end

  private

  def user_params_update
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

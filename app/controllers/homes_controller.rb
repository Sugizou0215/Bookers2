class HomesController < ApplicationController
  def top
    @books = Book.all
  end

  def about
  end
end

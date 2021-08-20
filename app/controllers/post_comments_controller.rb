class PostCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
    comment = PostComment.new(post_comment_params)
		comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
    	redirect_to book_path(book), notice: 'You have updated comment successfully.'
    end
  end

  def destroy
  	PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

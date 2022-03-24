class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    render :validater unless @book_comment.save
  end



  def destroy
     @book = Book.find(params[:book_id])
     book_comment = @book.book_comments.find(params[:id])
     book_comment.destroy
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end

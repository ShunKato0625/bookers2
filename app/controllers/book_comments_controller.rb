class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id #どの投稿にコメントするか
    @comment_new = BookComment.new
    if @comment.save
      redirect_to book_path(@book)
    else
      @user = @book.user
      render 'books/show'
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    @book = Book.find(params[:book_id])
    @comment_new = BookComment.new
    comment.destroy
    redirect_to book_path(@book)
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end

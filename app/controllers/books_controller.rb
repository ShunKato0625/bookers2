class BooksController < ApplicationController

  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
       @books = Book.all
       @user = User.find(current_user.id)
       render "index"
    end
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path(@book), method: :delete
    flash[:notice] = "Book was successfully destroyed."
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
       render "edit"
    else
       redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
       redirect_to book_path(@book), notice:'You have updated book successfully.'
    else
       render "edit"
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
  end



  private

  def book_params
    params.require(:book).permit(:title,:body)
  end


end


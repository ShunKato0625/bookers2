class BooksController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions => [:show]

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
    @user = User.find(current_user.id)
    @book = Book.new
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).sort { |a, b| b.favorited_users.size <=> a.favorited_users.size }
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:rate_count]
      @books = Book.rate_count
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:session_hash])
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
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
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
    params.require(:book).permit(:title, :body, :rate, :category)
  end
end

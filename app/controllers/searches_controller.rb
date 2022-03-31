class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'User'
			@records = User.search_for(@content, @method)
		elsif @model == 'Book'
			@records = Book.search_for(@content, @method)
		elsif @model == 'Category'
			@records = Category.search_books_for(@content, @method)
		end
  end
end
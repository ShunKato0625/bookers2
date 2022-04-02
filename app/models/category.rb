class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories

  def self.search_books_for(content, method)
    if method == 'perfect'
      Category.where(name: content)
    elsif method == 'forward'
      Category.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Category.where('name LIKE ?', '%' + content)
    else
      Category.where('name LIKE ?', '%' + content + '%')
    end
  end
end

class Author < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :author_books
  has_many :books, through: :author_books

end

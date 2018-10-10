class AuthorBook < ApplicationRecord
  belongs_to :author_books
  belongs_to :books

end

class AuthorBook < ApplicationRecord
  belongs_to :author
  belongs_to :books
end

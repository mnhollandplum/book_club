class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def reviews_count
    reviews.size
  end

  def average_score
    reviews.average(:score)
  end
end

class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def reviews_count
    reviews.count
  end

  def average_score
    reviews.average(:score)
  end

  def self.sortby(criteria, dir)
    if criteria == :page_num
      order(pages: dir)
    elsif criteria ==
    :avg_rating
      select('books.*, avg(reviews.score) as average_score').joins(:reviews).group(:id).order("average_score #{dir}")
    elsif criteria == :review_num
      select('books.*, reviews.count as count').joins(:reviews).group(:id).order("count #{dir}")
    end

  end


end

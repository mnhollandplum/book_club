class User < ApplicationRecord
  validates_presence_of :username
  has_many :reviews

  def reviews_count
    reviews.count
  end

  def reviews_bydate(dir)
    reviews.order("created_at #{dir}")
  end

  def self.top_reviewers
      select('users.*, reviews.count as count').joins(:reviews).group(:id).order(:count).reverse_order
  end

end

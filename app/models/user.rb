class User < ApplicationRecord
  validates_presence_of :username
  has_many :reviews

  def reviews_count
    reviews.count
  end

  def reviews_sortby(dir)
    reviews.order("created_at #{dir}")
  end

end

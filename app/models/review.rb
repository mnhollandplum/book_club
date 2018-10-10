class Review < ApplicationRecord
  validates_presence_of :title, :explanation, :score
  belongs_to :user
  belongs_to :book
end

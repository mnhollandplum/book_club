class Book < ApplicationRecord
 validates_presence_of :title, :pages, :year
 has_many :author_books
 has_many :authors, through: :author_books
 has_many :reviews

 def reviews_count
   if reviews.count == nil
     then result = 0.0
   else result = reviews.count
   end
   result
 end

 def average_score
   if reviews.average(:score) == nil
     then result = 0.0
   else result = reviews.average(:score).to_f.round(2)
   end
   result
 end

 def sort_reviews(dir)
   reviews.order("score #{dir}").limit(3)
 end

 def self.sortby(criteria, dir)
   if criteria == :page_num
     order(pages: dir)
   elsif criteria == :avg_rating
     select('books.*, avg(reviews.score) as average_score').left_outer_joins(:reviews).group(:id).order("average_score #{dir}")
   elsif criteria == :review_num
     select('books.*, reviews.count as count').left_outer_joins(:reviews).group(:id).order("count #{dir}")
   end
 end
end

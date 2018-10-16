class Book < ApplicationRecord
 validates_presence_of :title, :pages, :year
 has_many :author_books
 has_many :authors, through: :author_books
 has_many :reviews

 def reviews_count
   if reviews.count == 0
     then result = 0.0
   else result = reviews.count
   end
   result
 end

 def average_rating
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
    if dir == :asc
      select('books.*, avg(reviews.score) as average_rating').left_outer_joins(:reviews).group(:id).order("average_rating #{dir} NULLS FIRST")
    else
      select('books.*, avg(reviews.score) as average_rating').left_outer_joins(:reviews).group(:id).order("average_rating #{dir} NULLS LAST")
    end
   elsif criteria == :review_num
    if dir == :asc
      select('books.*, reviews.count as count').left_outer_joins(:reviews).group(:id).order("count #{dir} NULLS FIRST")
    else
      select('books.*, reviews.count as count').left_outer_joins(:reviews).group(:id).order("count #{dir} NULLS LAST")
    end
   end
 end
end

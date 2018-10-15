require 'rails_helper'
describe 'user sees author show page' do
  it 'should show a list of books by an author' do

     book_1 = Book.create(id: 1, title: "Norm's book", pages: 1566, year: 1967)
     author_1 = book_1.authors.create(id: 1, first_name: "Norm", last_name: "Schultz")

     user_1 = User.create(username: "funky1")
     user_2 = User.create(username: "notfunky")

     review_1 = book_1.reviews.create(title: "This is review 1", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
     review_2 = book_1.reviews.create(title: "This is review 2", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)

        visit "/authors/1"

     expect(page).to have_content(author_1.first_name)
     expect(page).to have_content(author_1.last_name)

     expect(page).to have_content(book_1.title)

     expect(page).to have_content(review_1.title)
     expect(page).to_not have_content(review_2.title)

   end
  end

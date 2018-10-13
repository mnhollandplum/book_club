require 'rails_helper'

describe 'user sees individual book information' do
  it 'user sees basic attributes' do
    book_1 = Book.create(id: 1, title: "Norm's book", pages: 1566, year: 1967)
    author_1 = book_1.authors.create(first_name: "Norm", last_name: "Schultz")
    user_1 = User.create(username: "funky1")
    user_2 = User.create(username: "notfunky")
    review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)

    visit '/books/1'

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Length: #{book_1.pages}")
    expect(page).to have_content("Published in: #{book_1.year}")
  end

end

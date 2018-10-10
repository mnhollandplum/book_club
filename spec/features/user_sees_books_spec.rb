require 'rails_helper'

describe 'user sees book information' do
  it 'user sees basic attributes' do
    book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
    book_2 = Book.create(title: "Nikki's book", pages: 2, year: 1990)

    visit '/books'

    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.pages)
    expect(page).to have_content(book_1.year)
    expect(page).to have_content(book_2.title)
    expect(page).to have_content(book_2.pages)
    expect(page).to have_content(book_2.year)
  end

  it 'user sees authors for books' do
    book_1 = Book.create!(title: "Norm's book", pages: 1566, year: 1967)
    book_2 = Book.create!(title: "Nikki's book", pages: 2, year: 1990)
    author_1 = book_1.authors.create(first_name: "Norm", last_name: "Schultz")
    author_2 = book_2.authors.create(first_name: "Nikki", last_name: "Holland-Plum")

    visit '/books'

    expect(page).to have_content(author_1.first_name)
  end

  # it 'user sees average book rating' do
  #   book_1 = Book.create!(title: "Norm's book", pages: 1566, year: 1967)
  #   book_2 = Book.create!(title: "Nikki's book", pages: 2, year: 1990)
  #   review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5)
  #   review_2 = book_2.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 5)
  # 
  #   visit '/books'
  #
  #   expect(page).to have_content("Average Review #{review_1.score}")
  # end

end

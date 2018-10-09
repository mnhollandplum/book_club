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
end

require 'rails_helper'
describe 'user sees author show page' do
  it 'should show a list of books by an author' do

     book_1 = Book.create(id: 1, title: "Norm's book", pages: 1566, year: 1967)
     author_1 = book_1.authors.create(id: 1, first_name: "Norm", last_name: "Schultz")

        visit author_path("1")

     expect(page).to have_content(author_1.first_name)
     expect(page).to have_content(author_1.last_name)

     expect(page).to have_content(book_1.title)
   end
  end

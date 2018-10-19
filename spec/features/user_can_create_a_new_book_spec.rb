require 'rails_helper'

describe 'user can create a new book' do
  it 'user sees new form' do

  visit new_book_path

  title = "new book"
  pages = "199"
  year = "2018"
  first_name = "Nikki"
  last_name = "Holland"

  fill_in 'book[title]', with: title
  fill_in 'book[pages]', with: pages
  fill_in 'book[year]', with: year

click_on "Create Book"

  expect(page).to have_content("new book")
  expect(page).to have_content("199")

  end
end

# author language for form
# <!-- Author
# <%= f.label :first_name %>
#   <%= f.text_field :first_name, placeholder:'First Name' %>
# <%= f.label :last_name %>
#   <%= f.text_field :last_name, placeholder:'Last Name' %> -->

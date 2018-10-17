require 'rails_helper'
describe 'user sees user show page' do
  before(:each) do
    @book_1 = Book.create(title: "Norms book", pages: 1566, year: 1967)
    @book_2 = Book.create(title: "Nikkis book", pages: 2, year: 1990)
    @book_3 = Book.create(title: "Rafaels book", pages: 10, year: 1991)

    @author_1 = @book_1.authors.create(first_name: "Norm", last_name: "Schultz")
    @author_2 = @book_2.authors.create(first_name: "Nikki", last_name: "Holland-Plum")
    @author_2 = @book_3.authors.create(first_name: "Xander", last_name: "Harris")

    @user_1 = User.create(id: 1, username: "funky1")
    @user_2 = User.create(id: 2, username: "dontshow")

    @review_1 = @book_1.reviews.create(title: "a", explanation: "This is the Latest Review", score: 5, user: @user_1, created_at: Time.now + 4)
    @review_2 = @book_1.reviews.create(title: "b", explanation: "This is the Middle Review", score: 3, user: @user_1, created_at: Time.now + 2)
    @review_3 = @book_2.reviews.create(title: "c", explanation: "This is the Earliest review", score: 1, user: @user_1, created_at: Time.now)
    @review_4 = @book_2.reviews.create(title: "d", explanation: "This should not be on the user_2 page", score: 1, user: @user_2, created_at: Time.now)
  end

  it 'should show the username of the user' do
      visit "/users/1"
      expect(page).to have_content(@user_1.username)
      expect(page).to_not have_content(@user_2.username)
  end

  it 'should show all of the users reviews' do
    visit "/users/1"
     expect(page).to have_content("Title: #{@review_1.title}")
     expect(page).to have_content("Title: #{@review_2.title}")
     expect(page).to have_content("Title: #{@review_3.title}")
     expect(page).to_not have_content("Title: #{@review_4.title}")
   end

  it 'should allow user to sort reviews by descending chronological order' do
    visit "/users/1"
    find('.dropdown-menu', :text => 'Descending').click
    expect(page.body.index(@review_3.explanation) > page.body.index(@review_2.explanation)).to eq(true)
    expect(page.body.index(@review_2.explanation) > page.body.index(@review_1.explanation)).to eq(true)
  end

  it 'should allow user to sort reviews by ascending chronological order' do
    visit "/users/1"
    find('.dropdown-menu', :text => 'Ascending').click
    expect(page.body.index(@review_3.explanation) > page.body.index(@review_2.explanation)).to eq(true)
    expect(page.body.index(@review_2.explanation) > page.body.index(@review_1.explanation)).to eq(true)
  end
end

describe 'user sees user show page' do
  it 'should delete review from user show page' do
    @book_1 = Book.create(title: "Norms book", pages: 1566, year: 1967)

    @author_1 = @book_1.authors.create(first_name: "Norm", last_name: "Schultz")

    @user_1 = User.create(id: 1, username: "funky1")
    @user_2 = User.create(id: 2, username: "dontshow")

    @review_100 = @book_1.reviews.create(id: 100, title: "100", explanation: "a", score: 5, user: @user_1, created_at: Time.now + 4)
    @review_101 = @book_1.reviews.create(id: 101, title: "101", explanation: "b", score: 3, user: @user_2, created_at: Time.now + 2)

    visit user_path(1)
    within("id=review_#{@review_100.id}")
    click_on 'destroy'

    expect(page).to_not have_content(review_100.title)


  end
end

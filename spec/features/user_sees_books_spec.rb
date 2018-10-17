require 'rails_helper'

describe 'user sees book information' do
  it 'user sees basic attributes' do
    book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
    book_2 = Book.create(title: "Nikki's book", pages: 2, year: 1990)
    author_1 = book_1.authors.create(first_name: "Norm", last_name: "Schultz")
    author_2 = book_2.authors.create(first_name: "Nikki", last_name: "Holland-Plum")
    user_1 = User.create(username: "funky1")
    user_2 = User.create(username: "notfunky")
    review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)

    visit books_path

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content("Pages: #{book_2.pages}")
    expect(page).to have_content("Year: #{book_2.year}")
    expect(page).to have_content("Rating: #{book_1.average_rating}")
    expect(page).to have_content("Total Reviews: #{book_1.reviews_count}")
    expect(page).to have_content("#{author_1.first_name}")
    expect(page).to have_content("#{author_1.last_name}")
    expect(page).to have_content("#{author_2.first_name}")
    expect(page).to have_content("#{author_2.last_name}")
  end
end

describe 'user can sort by buttons' do
  before(:each) do
    @book_1 = Book.create(title: "Norms book", pages: 1566, year: 1967)
    @book_2 = Book.create(title: "Nikkis book", pages: 2, year: 1990)
    @book_3 = Book.create(title: "Rafaels book", pages: 10, year: 1991)
    @book_4 = Book.create(title: "Aarons book", pages: 50, year: 1992)
    @book_5 = Book.create(title: "Arnolds book", pages: 900, year: 1993)

    author_1 = @book_1.authors.create(first_name: "Norm", last_name: "Schultz")
    author_2 = @book_2.authors.create(first_name: "Nikki", last_name: "Holland-Plum")
    author_2 = @book_3.authors.create(first_name: "Xander", last_name: "Harris")
    author_3 = @book_4.authors.create(first_name: "Buffy", last_name: "Summers")
    author_4 = @book_5.authors.create(first_name: "Willow", last_name: "Willow Rosenberg")

    user_1 = User.create(username: "funky1")
    user_2 = User.create(username: "notfunky")
    user_3 = User.create(username: "superfunky")

    review_1 = @book_1.reviews.create(title: "a", explanation: "This is the first review for book 1", score: 5, user: user_1)
    review_2 = @book_1.reviews.create(title: "b", explanation: "This is the second review for book 1", score: 4, user: user_2)
    review_3 = @book_2.reviews.create(title: "c", explanation: "This is the first review for book 2", score: 3, user: user_1)
    review_4 = @book_3.reviews.create(title: "d", explanation: "This is the first review for book 3", score: 2, user: user_1)
    review_5 = @book_3.reviews.create(title: "e", explanation: "This is the second review for book 3", score: 3, user: user_2)
    review_6 = @book_3.reviews.create(title: "f", explanation: "This is the third review for book 3", score: 5, user: user_3)
    review_7 = @book_4.reviews.create(title: "g", explanation: "This is the only review for book 4", score: 1, user: user_1)
  end

  it 'user can sort ascending by average rating' do
  visit books_path('criteria=avg_rating&dir=asc')
  expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
  expect(page.body.index(@book_2.title) < page.body.index(@book_4.title)).to eq(true)
  expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
  expect(page.body.index(@book_1.title) < page.body.index(@book_3.title)).to eq(true)
  end

  it 'user can sort descending by average rating' do
    visit books_path('criteria=avg_rating&dir=desc')
    expect(page.body.index(@book_5.title) < page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_4.title) > page.body.index(@book_2.title)).to eq(true)
    expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
    expect(page.body.index(@book_1.title) < page.body.index(@book_5.title)).to eq(true)
  end

  it 'user can sort ascending by page number' do
    visit books_path('criteria=page_num&dir=asc')
    expect(page.body.index(@book_2.title) < page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_3.title) < page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_4.title) > page.body.index(@book_3.title)).to eq(true)
    expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
  end

  it 'user can sort descending by page number' do
    visit books_path('criteria=page_num&dir=desc')
    expect(page.body.index(@book_2.title) > page.body.index(@book_3.title)).to eq(true)
    expect(page.body.index(@book_3.title) < page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
    expect(page.body.index(@book_5.title) > page.body.index(@book_1.title)).to eq(true)
  end

  it 'user can sort ascending by number of reviews' do
    visit books_path('criteria=review_num&dir=asc')
    expect(page.body.index(@book_3.title) > page.body.index(@book_1.title)).to eq(true)
    expect(page.body.index(@book_1.title) < page.body.index(@book_2.title)).to eq(true)
    expect(page.body.index(@book_2.title) < page.body.index(@book_5.title)).to eq(true)
    expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
  end

  it 'user can sort descending by number of reviews' do
    visit books_path('criteria=review_num&dir=desc')
    expect(page.body.index(@book_5.title) < page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_5.title) > page.body.index(@book_2.title)).to eq(true)
    expect(page.body.index(@book_2.title) > page.body.index(@book_1.title)).to eq(true)
    expect(page.body.index(@book_1.title) < page.body.index(@book_3.title)).to eq(true)
  end
end

describe 'user sees statistics' do
  before(:each) do
    author_1 = Author.create(first_name: "Norm", last_name: "Schultz")
    author_2 = Author.create(first_name: "Nikki", last_name: "Holland-Plum")
    author_3 = Author.create(first_name: "Buffy", last_name: "Summers")
    author_4 = Author.create(first_name: "Willow", last_name: "Willow Rosenberg")
    author_5 = Author.create(first_name: "Xander", last_name: "Harris")

    @book_1 = author_1.books.create(title: "Book 1", pages: 1566, year: 1967)
    @book_2 = author_2.books.create(title: "Book 2", pages: 2, year: 1990)
    @book_3 = author_3.books.create(title: "Book 3", pages: 10, year: 1991)
    @book_4 = author_4.books.create(title: "Book 4", pages: 50, year: 1992)
    @book_5 = author_5.books.create(title: "Book 5", pages: 900, year: 1993)
    @book_6 = author_5.books.create(title: "Book 6", pages: 400, year: 1992)
    @book_7 = author_5.books.create(title: "Book 7", pages: 500, year: 1991)


    @user_1 = User.create(username: "User1")
    @user_2 = User.create(username: "User2")
    @user_3 = User.create(username: "User3")
    @user_4 = User.create(username: "User4")
    @user_5 = User.create(username: "User5")

    review_1 = @book_1.reviews.create(title: "a", explanation: "Review1", score: 5, user: @user_1)
    review_2 = @book_1.reviews.create(title: "b", explanation: "Review2", score: 4, user: @user_2)
    review_3 = @book_2.reviews.create(title: "c", explanation: "Review3", score: 3, user: @user_3)
    review_4 = @book_3.reviews.create(title: "d", explanation: "Review4", score: 2, user: @user_3)
    review_5 = @book_3.reviews.create(title: "e", explanation: "Review5", score: 3, user: @user_2)
    review_6 = @book_3.reviews.create(title: "f", explanation: "This is the third review for book 3", score: 5, user: @user_4)
    review_7 = @book_6.reviews.create(title: "g", explanation: "This is the third review for book 3", score: 2, user: @user_4)
    review_8 = @book_7.reviews.create(title: "h", explanation: "This is the third review for book 3", score: 1, user: @user_4)
    review_9 = @book_6.reviews.create(title: "i", explanation: "This is the third review for book 3", score: 2, user: @user_3)
    review_10 = @book_7.reviews.create(title: "j", explanation: "This is the third review for book 3", score: 2, user: @user_3)
    review_11 = @book_5.reviews.create(title: "l", explanation: "This is the third review for book 3", score: 1, user: @user_4)
  end

  it 'user can see top three books' do
    visit books_path
    within(".top_three") do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_3.title)
      expect(page).to_not have_content(@book_4.title)

    end
  end

  it 'user can see bottom three books' do
    visit books_path
    within(".bottom_three") do

      expect(page).to have_content(@book_5.title)
      expect(page).to have_content(@book_4.title)
      expect(page).to have_content(@book_7.title)
      expect(page).to_not have_content(@book_6.title)
    end
  end

  it 'user can see top three reviewers' do
    visit books_path
    within(".jumbotron") do
      expect(page).to have_content(@user_4.username)
      expect(page).to have_content(@user_2.username)
      expect(page).to have_content(@user_3.username)
      expect(page).to_not have_content(@user_1.username)
      expect(page).to_not have_content(@user_5.username)
    end
  end

end

describe 'user can delete an author' do
  it 'user wont see the author no mo' do
    book_100 = Book.create(id: 100, title: "Book 100", pages: 1566, year: 1967)
    book_101 = Book.create(id: 101, title: "Book 101", pages: 2, year: 1990)
    author_100 = book_100.authors.create(id: 100, first_name: "Norm", last_name: "Schultz")
    author_101 = book_100.authors.create(id: 101, first_name: "Nikki", last_name: "Holland-Plum")
    author_102 = book_101.authors.create(id: 102, first_name: "Bob", last_name: "Smith")

    visit author_path(100)
    click_on "destroy"

    expect(page).to_not have_content (author_100.first_name)
    expect(page).to_not have_content (author_100.last_name)

  end



end

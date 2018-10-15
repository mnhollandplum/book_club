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

    visit '/books'

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content("Pages: #{book_2.pages}")
    expect(page).to have_content("Year: #{book_2.year}")
    expect(page).to have_content("Rating: #{book_1.average_score}")
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
    visit '/books?criteria=avg_rating&dir=asc'
    expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
    expect(page.body.index(@book_2.title) > page.body.index(@book_4.title)).to eq(true)
    expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
    expect(page.body.index(@book_1.title) < page.body.index(@book_3.title)).to eq(true)
    end

    it 'user can sort descending by average rating' do
      visit '/books?criteria=avg_rating&dir=desc'
      expect(page.body.index(@book_5.title) < page.body.index(@book_4.title)).to eq(true)
      expect(page.body.index(@book_4.title) < page.body.index(@book_2.title)).to eq(true)
      expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
      expect(page.body.index(@book_1.title) > page.body.index(@book_5.title)).to eq(true)
    end

    it 'user can sort ascending by page number' do
      visit '/books?criteria=page_num&dir=asc'
      expect(page.body.index(@book_2.title) > page.body.index(@book_4.title)).to eq(true)
      expect(page.body.index(@book_3.title) < page.body.index(@book_4.title)).to eq(true)
      expect(page.body.index(@book_4.title) > page.body.index(@book_3.title)).to eq(true)
      expect(page.body.index(@book_3.title) < page.body.index(@book_2.title)).to eq(true)
    end

    it 'user can sort descending by page number' do
      visit '/books?criteria=page_num&dir=desc'
      expect(page.body.index(@book_2.title) > page.body.index(@book_3.title)).to eq(true)
      expect(page.body.index(@book_3.title) < page.body.index(@book_4.title)).to eq(true)
      expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
      expect(page.body.index(@book_5.title) < page.body.index(@book_1.title)).to eq(true)
    end

    it 'user can sort ascending by number of reviews' do
      visit '/books?criteria=review_num&dir=asc'
      expect(page.body.index(@book_3.title) > page.body.index(@book_1.title)).to eq(true)
      expect(page.body.index(@book_1.title) < page.body.index(@book_2.title)).to eq(true)
      expect(page.body.index(@book_2.title) > page.body.index(@book_5.title)).to eq(true)
      expect(page.body.index(@book_4.title) > page.body.index(@book_5.title)).to eq(true)
    end

    it 'user can sort descending by number of reviews' do
      visit '/books?criteria=review_num&dir=desc'
      expect(page.body.index(@book_5.title) < page.body.index(@book_4.title)).to eq(true)
      expect(page.body.index(@book_5.title) < page.body.index(@book_2.title)).to eq(true)
      expect(page.body.index(@book_2.title) > page.body.index(@book_1.title)).to eq(true)
      expect(page.body.index(@book_1.title) < page.body.index(@book_3.title)).to eq(true)
    end

end

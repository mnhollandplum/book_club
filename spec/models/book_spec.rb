require 'rails_helper'

describe Book, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:year)}
  end

  describe 'relationships' do
    it { should have_many(:authors).through(:author_books)}
    it { should have_many(:author_books)}
    it { should have_many(:reviews)}
  end

  describe 'class functionality' do
    it 'returns review count' do
      book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
      user_1 = User.create(username: "funky1")
      user_2 = User.create(username: "notfunky")
      review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
      review_2 = book_1.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)
      actual = book_1.reviews_count
      expected = 2
      expect(actual).to eq(expected)
    end

    it 'returns average review score' do
      book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
      user_1 = User.create(username: "funky1")
      user_2 = User.create(username: "notfunky")
      review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
      review_2 = book_1.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)
      actual = book_1.average_score
      expected = 4
      expect(actual).to eq(expected)
    end

    describe 'books sorting functions' do
      before(:each) do
        @book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
        @book_2 = Book.create(title: "Nikki's book", pages: 2, year: 1990)
        @book_3 = Book.create(title: "Dan's book", pages: 420, year: 1955)
        @book_4 = Book.create(title: "Tim's book", pages: 211, year: 1999)
        user_1 = User.create(username: "funky1")
        user_2 = User.create(username: "notfunky")
        user_3 = User.create(username: "badabingbadaboom")
        user_4 = User.create(username: "getmeaquarterpounder")
        review_1 = @book_1.reviews.create(title: "This is Norm's review", explanation: "This is an explanation of the review", score: 5, user: user_1)
        review_2 = @book_2.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 3, user: user_2)
        review_3 = @book_3.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 4, user: user_3)
        review_4 = @book_4.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 2, user: user_4)
      end

      xit 'sorts by average ratings' do
        expect(Book.sortby(:avg_rating, :asc)).to eq(@book_4)
        expect(Book.sortby(:avg_rating, :desc)).to eq(@book_1)
      end

      it 'sorts by pages' do
        expect(Book.sortby(:page_num, :asc)).to eq([@book_2, @book_4, @book_3, @book_1])
        expect(Book.sortby(:page_num, :desc)).to eq([@book_1, @book_3, @book_4, @book_2])
      end

      xit 'sorts by number of reviews' do
        expect(Book.sortby(:avg_rating, :asc).first).to eq(@book_4)
        expect(Book.sortby(:avg_rating, :asc).last).to eq(@book_1)
      end
    end
  end
end

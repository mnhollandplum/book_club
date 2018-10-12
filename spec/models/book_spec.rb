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

  describe 'instance functionality' do
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

    it 'sorts reviews' do
      @book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)

      user_1 = User.create(username: "funky1")
      user_2 = User.create(username: "notfunky")
      user_3 = User.create(username: "badabingbadaboom")
      user_4 = User.create(username: "getmeaquarterpounder")
      user_5 = User.create(username: "iandouglas")
      user_6 = User.create(username: "zachadoo")
      user_7 = User.create(username: "thylvethter")
      user_8 = User.create(username: "kaykkkate")

      review_1 = @book_1.reviews.create(title: "Review 1", explanation: "This is an explanation of the review", score: 5, user: user_1)
      review_2 = @book_1.reviews.create(title: "Review 2", explanation: "This is an explanation of the review", score: 3, user: user_2)
      review_3 = @book_1.reviews.create(title: "Review 3", explanation: "This is an explanation of the review", score: 4, user: user_3)
      review_4 = @book_1.reviews.create(title: "Review 4", explanation: "This is an explanation of the review", score: 2, user: user_4)
      review_5 = @book_1.reviews.create(title: "Review 5", explanation: "This is an explanation of the review", score: 3, user: user_5)
      review_6 = @book_1.reviews.create(title: "Review 6", explanation: "This is an explanation of the review", score: 3, user: user_5)
      review_7 = @book_1.reviews.create(title: "Review 7", explanation: "This is an explanation of the review", score: 1, user: user_5)
      actual = @book_1.sort_reviews(:asc)
      expect(actual).to include(review_7)
      expect(actual).to include(review_4)
      expect(actual.last.score).to eq(3)

      actual = @book_1.sort_reviews(:desc)
      expect(actual).to include(review_1)
      expect(actual).to include(review_3)
      expect(actual.last.score).to eq(3)

    end

  end

  describe 'class functionality' do

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
        user_5 = User.create(username: "iandouglas")

        review_1 = @book_1.reviews.create(title: "This is Norm's review", explanation: "This is an explanation of the review", score: 5, user: user_1)
        review_2 = @book_2.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 3, user: user_2)
        review_3 = @book_3.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 4, user: user_3)
        review_4 = @book_4.reviews.create(title: "This is Nikki's review", explanation: "This is an explanation of the review", score: 2, user: user_4)
        review_5 = @book_4.reviews.create(title: "This is Ian's", explanation: "This is an explanation of the review", score: 3, user: user_5)

      end

      it 'sorts by average ratings' do
        expect(Book.sortby(:avg_rating, :asc)).to eq([@book_4, @book_2, @book_3, @book_1])
        expect(Book.sortby(:avg_rating, :DESC)).to eq([@book_1, @book_3, @book_2, @book_4])
      end

      it 'sorts by pages' do
        expect(Book.sortby(:page_num, :asc)).to eq([@book_2, @book_4, @book_3, @book_1])
        expect(Book.sortby(:page_num, :desc)).to eq([@book_1, @book_3, @book_4, @book_2])
      end

      it 'sorts by number of reviews' do
        expect(Book.sortby(:review_num, :asc).first).not_to eq(@book_4)
        expect(Book.sortby(:review_num, :desc).first).to eq(@book_4)
      end
    end
  end
end

require 'rails_helper'

describe Book, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:year)}
  end

  describe 'relationships' do
    it { should have_many(:authors).through (:author_books)}
    it { should have_many(:reviews)}
  end

  describe 'class functionality' do
    it 'returns review count' do

    book_1 = Book.create!(title: "Norm's book", pages: 1566, year: 1967)

    review_1 = book_1.reviews.create(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5)
    review_2 = book_1.reviews.create(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 5)

    actual = book_1.reviews_count
    expected = 2

    expect(actual).to eq(expected)
    end

    it 'returns average review score' do
      book_1 = Book.create!(title: "Norm's book", pages: 1566, year: 1967)

      user_1 = User.create!(username: "funky1")
      user_2 = User.create!(username: "notfunky")

      review_1 = book_1.reviews.create!(title: "This is Norm's review", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
      review_2 = book_1.reviews.create!(title: "This is Nikki's review", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)



      actual = book_1.average_score
      expected = 4

      expect(actual).to eq(expected)
    end
  end
end

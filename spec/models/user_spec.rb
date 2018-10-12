require 'rails_helper'
require 'time'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:username)}

  end

  describe 'relationships' do
    it { should have_many(:reviews)}
  end

  describe 'class functionality' do
    before(:each) do
      book_1 = Book.create(title: "Norm's book", pages: 1566, year: 1967)
      book_2 = Book.create(title: "Nikki's book", pages: 2, year: 1990)
      book_3 = Book.create(title: "Dan's book", pages: 420, year: 1955)
      book_4 = Book.create(title: "Tim's book", pages: 211, year: 1999)

      @user_1 = User.create(username: "funky1")
      @user_2 = User.create(username: "notfunky")
      @user_3 = User.create(username: "badabingbadaboom")

      @review_1 = book_1.reviews.create(title: "review 1", explanation: "This is an explanation of the review", score: 5, user: @user_1)
      @review_2 = book_2.reviews.create(title: "review 2", explanation: "This is an explanation of the review", score: 3, user: @user_2)
      @review_3 = book_3.reviews.create(title: "review 3", explanation: "This is an explanation of the review", score: 4, user: @user_3, created_at: Time.now )
      @review_4 = book_4.reviews.create(title: "review 4", explanation: "This is an explanation of the review", score: 2, user: @user_3, created_at: Time.now + 1.days)
      @review_5 = book_4.reviews.create(title: "review 5", explanation: "This is an explanation of the review", score: 3, user: @user_3, created_at: Time.now + 2.days)
      @review_6 = book_3.reviews.create(title: "review 6", explanation: "This is an explanation of the review", score: 3, user: @user_2)
    end

    it 'returns review count' do
      actual = @user_3.reviews_count
      expected = 3
      expect(actual).to eq(expected)
    end

    it 'sorts by number of reviews' do
      expect(@user_3.reviews_sortby(:asc).first).to eq(@review_3)
      expect(@user_3.reviews_sortby(:desc).first).to eq(@review_5)
    end

  end

end

require 'rails_helper'

describe 'user sees individual book information' do
  before(:each) do
    @book = Book.create(id: 1, title: "Norm's book", pages: 1566, year: 1967)
    author_1 = @book.authors.create(first_name: "Norm", last_name: "Schultz")
    user_1 = User.create(username: "funky1")
    user_2 = User.create(username: "notfunky")
    user_3 = User.create(username: "sortoffunky")
    user_4 = User.create(username: "reallyfunky")
    user_5 = User.create(username: "zachadoo")
    user_6 = User.create(username: "ian")
    user_7 = User.create(username: "thedude")
    @review_1 = @book.reviews.create(title: "This is review 1", explanation: "This is Norm's explanation of the review", score: 5, user: user_1)
    @review_2 = @book.reviews.create(title: "This is review 2", explanation: "This is Nikki's explanation of the review", score: 3, user: user_2)
    @review_3 = @book.reviews.create(title: "This is review 3", explanation: "This is another explanation of the review", score: 4, user: user_3)
    @review_4 = @book.reviews.create(title: "This is review 4", explanation: "This is one more explanation of the review", score: 5, user: user_4)
    @review_5 = @book.reviews.create(title: "This is review 5", explanation: "This is one more explanation of the review", score: 2, user: user_5)
    @review_6 = @book.reviews.create(title: "This is review 6", explanation: "This is one more explanation of the review", score: 2, user: user_6)
    @review_7 = @book.reviews.create(title: "This is review 7", explanation: "This is one more explanation of the review", score: 1, user: user_7)

  end

  it 'user sees basic attributes' do
    visit book_path(@book)

    expect(page).to have_content(@book.title)
    expect(page).to have_content("Length: #{@book.pages}")
    expect(page).to have_content("Published in: #{@book.year}")
    expect(page).to have_content("Average Review Score: #{@book.average_score}")
  end

  it 'user sees book statistics' do
    visit book_path(@book)
    within(".top_three") do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_4.title)
      expect(page).to have_content(@review_3.title)

    end
    within(".bottom_three") do
      expect(page).to have_content(@review_7.title)
      expect(page).to have_content(@review_6.title)
      expect(page).to have_content(@review_5.title)

    end


  end

end

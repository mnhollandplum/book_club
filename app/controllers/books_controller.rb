class BooksController < ApplicationController

  def index
    @top_three            = Book.all.sortby(:avg_rating, :desc).limit(3)
    @bottom_three         = Book.all.sortby(:avg_rating, :asc).limit(3)
    @top_three_reviewers  = User.all.top_reviewers.limit(3)

    if params['criteria']
      @books = Book.all.sortby(params['criteria'].to_sym, params['dir'].to_sym)
    else
      @books = Book.all
    end

  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    AuthorBook.where(book_id: params['id']).destroy_all
    Review.where(book_id: params['id']).destroy_all
    @book.destroy
    redirect_to books_path
  end

  # def destroy
  #  book = Book.find(params[:id])
  #  redirect_to books_path
  # end

  def new
    @book = Book.new
    @author = @book.authors.new
  end

  def create
    book = Book.create(book_params)

    redirect_to books_path(book)
  end

private

  def book_params
    params.require(:book).permit(:title, :pages, :year, author_attributes: [:id, :first_name, :last_name])
  end

end

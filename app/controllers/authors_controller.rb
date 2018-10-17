class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = Book.where(id: @author.id)
  end

  def destroy
    gone_author = Author.find(params[:id])
    gone_author.books.each do |book|
      book.destroy if book.authors.length == 1
    end
    AuthorBook.where(author_id: params['id']).destroy_all
    Author.destroy(params['id'])
    redirect_to books_path
  end

end

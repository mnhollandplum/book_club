class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = Book.where(id: @author.id)
  end
end

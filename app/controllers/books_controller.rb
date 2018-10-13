class BooksController < ApplicationController

  def index
    if params['criteria']
        @books = Book.all.sortby(params['criteria'].to_sym, params['dir'].to_sym)

    else
      @books = Book.all
    end
  end

end

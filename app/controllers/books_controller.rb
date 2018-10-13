class BooksController < ApplicationController

  def index
    @top_three     = Book.all.sortby(:avg_rating, :desc).limit(3)
    @bottom_three  = Book.all.sortby(:avg_rating, :asc).limit(3)

    if params['criteria']
      @books = Book.all.sortby(params['criteria'].to_sym, params['dir'].to_sym)

    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end



end

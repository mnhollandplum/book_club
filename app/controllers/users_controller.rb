class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    if params['dir'] == 'asc'
      @reviews = @user.reviews_bydate('asc')
    elsif params['dir'] == 'desc'
      @reviews = @user.reviews_bydate('desc')
    else
      @reviews = @user.reviews
    end
  end
end

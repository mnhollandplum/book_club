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

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to books_path
  end

  private
    def user_params
      params.require(:user).permit(:username)
    end

end

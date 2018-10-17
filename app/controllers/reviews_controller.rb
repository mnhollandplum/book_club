class ReviewsController < ApplicationController

  def destroy
  user = Review.find(params[:id]).user_id
  Review.destroy(params[:id])

  redirect_to user_path(user)
  end

end

class ReviewsController < ApplicationController

  before_action :authenticate_user!, :except => [ :index, :show ]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])

    if current_user.has_reviewed?(@restaurant)
      flash[:notice] = 'You already reviewed this restaurant'
      redirect_to '/restaurants'
    else
      @review = Review.new
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.new(review_params)
    @restaurant.reviews.last["user_id"] = current_user.id
    @restaurant.reviews.last.save
    redirect_to '/restaurants'
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end

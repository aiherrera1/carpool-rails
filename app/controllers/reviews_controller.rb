# frozen_string_literal: true

# Controller for model Review
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]
  before_action :set_user, only: %i[my_reviews reviews_user]

  # def show; end

  def my_reviews
    @reviews = @user.made_reviews
  end

  def reviews_user
    @reviews = @user.reviews
  end

  def new
    @review = Review.new
    session[:to_user_id] = params[:to_user_id]
    session[:carpool_id] = params[:carpool_id]
    @carpool = Carpool.find(params[:carpool_id])
  end

  # GET /reviews/1/edit
  def edit; end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(stars: params[:rate], title: params[:review][:title], comment: params[:review][:title])
    @review.update(to_user_id: session[:to_user_id], carpool_id: session[:carpool_id], from_user_id: current_user.id)
    if @review.carpool.driver.user.id == @review.to_user.id
      @review.update(type_of_review: 'To Driver')
    else
      @review.update(type_of_review: 'To Passenger')
    end

    if @review.save
      redirect_to carpool_path(@review.carpool)
      flash[:alert] = 'Your review was succesfully created'
    else
      render 'new'
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    if @review.update(review_params)
      redirect_to carpool_path(@review.carpool)
    else
      render 'edit'
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    redirect_to my_reviews_path(@review.from_user.id)
    @review.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:stars, :title, :comment)
  end
end

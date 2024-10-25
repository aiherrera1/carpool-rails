# frozen_string_literal: true

# Controller for model Favorites
class FavoritesController < ApplicationController
  def add_favorite
    @fav_user = User.find(params[:id])
    Favorite.create(user_id: current_user.id, favorite_user_id: @fav_user.id)
    flash[:alert] = "#{@fav_user.name} has been added to your favorites"
    redirect_to user_show_path(@fav_user)
  end

  def remove_favorite
    @fav_user = User.find(params[:id])
    Favorite.destroy_by(user_id: current_user.id, favorite_user_id: @fav_user.id)
    flash[:alert] = "#{@fav_user.name} has been removed from your favorites"
    redirect_to home_favorites_path
  end
end

# frozen_string_literal: true

# Controller for model UserInCarpool
class UsersInCarpoolController < ApplicationController
  before_action :authenticate_user!

  def remove_from_carpool
    @user_in_carpool = UserInCarpool.find(params[:id])
    @request = Request.find_by(user_id: @user_in_carpool.user_id, carpool_id: @user_in_carpool.carpool_id)
    @carpool = @request.carpool
    @request.update(result: 'Removed')
    @carpool.update(open_spots: @carpool.open_spots + 1)
    flash[:alert] = "#{@request.user.name} has been removed from this carpool"
    @user_in_carpool.destroy
    redirect_to carpool_path(@carpool)
  end
end

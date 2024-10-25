# frozen_string_literal: true

# Controller for model Request
class RequestsController < ApplicationController
  before_action :authenticate_user!

  def my_requests
    @requests = current_user.requests
  end

  def request_ride
    @carpool = Carpool.find(params[:id])
    Notification.create(user_id: @carpool.driver.user.id,
                        message: "#{current_user.name} has requested a spot in your carpool
                        #{@carpool.summary}", carpool_id: @carpool.id)
    if Request.where(user_id: current_user.id, carpool_id: @carpool.id).count.zero?
      Request.create(user_id: current_user.id, carpool_id: @carpool.id, result: 'Waiting')
    else
      @request = Request.find_by(user_id: current_user.id, carpool_id: @carpool.id)
      @request.update(result: 'Waiting')
    end
    redirect_to carpool_path(@carpool)
    flash[:alert] = 'Your request has been sent succesfully!'
  end

  def accept
    @request = Request.find(params[:id])
    @request.update(result: 'Accepted')
    @carpool = @request.carpool
    Notification.create(user_id: @request.user.id, message: "Your request
                        for carpool #{@carpool.summary} has been accepted", carpool_id: @carpool.id)
    @carpool.update(open_spots: @carpool.open_spots - 1)
    UserInCarpool.create(user_id: @request.user_id, carpool_id: @request.carpool_id)
    flash[:alert] = "#{@request.user.name} has been added to this carpool"
    if @carpool.open_spots.zero?
      @carpool.update(open_for_request: false)
      @carpool.requests.where(result: 'Waiting').each do |request|
        request.update(result: 'Rejected')
      end
    end
    redirect_to carpool_path(@carpool)
  end

  def reject
    @request = Request.find(params[:id])
    @request.update(result: 'Rejected')
    @carpool = @request.carpool
    Notification.create(user_id: @request.user.id,
                        message: "Your request for carpool #{@carpool.summary}
                        has been rejected", carpool_id: @carpool.id)
    redirect_to carpool_path(@carpool)
    flash[:alert] = "The request from #{@request.user.name} has been rejected"
  end

  def destroy
    @request = Request.find(params[:id])
    @carpool = @request.carpool
    if @request.result == 'Accepted'
      Notification.create(user_id: @carpool.driver.user.id,
                          message: "#{current_user.name} has left your carpool
                          #{@carpool.summary}", carpool_id: @carpool.id)
      UserInCarpool.destroy_by(user_id: @request.user_id, carpool_id: @request.carpool_id)
      @carpool.update(open_spots: @carpool.open_spots + 1)
      flash[:alert] = 'You have been removed from this carpool'
    else
      flash[:alert] = 'Your request for this ride has been canceled'
    end
    @request.destroy
    redirect_to carpool_path(@carpool)
  end
end

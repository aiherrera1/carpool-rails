# frozen_string_literal: true

# Controller for model Driver
class DriversController < ApplicationController
  before_action :set_driver, only: %i[show edit update delete]
  before_action :authenticate_user!

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.user_id = current_user.id
    if @driver.save
      flash[:alert] = 'You were successfully registered as driver!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @driver.update(driver_params)
      redirect_to user_show_path(current_user.id)
    else
      render 'edit'
    end
  end

  def delete
    @driver.destroy
    redirect_to root_path
    flash[:alert] = 'Your driver profile was succesfully deleted'
  end

  private

  def set_driver
    @driver = Driver.find_by(id: params[:id])
  end

  def driver_params
    params.require(:driver).permit(:driver_license_number, :license_plate, :car_description)
  end
end

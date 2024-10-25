# frozen_string_literal: true

# Controller of Home page
class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[guest index aboutus]

  def index
    current_user&.update(name: current_user.name.split.map(&:capitalize).join(' '))
  end

  def guest
    @carpools = Carpool.all.order(:date, :time_of_departure)
    @active_carpools = Carpool.where(
      'CONCAT(CAST(date AS VARCHAR(10)), CAST(time_of_departure as VARCHAR(10))) >= ?', Time.now
    ).order(:date, :time_of_departure)
  end

  def profile; end

  def favorites
    @favorites = current_user.favorites
  end

  def inbox
    @chatrooms = current_user.open_chatrooms
  end

  def notifications
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def aboutus; end

  def register_as_driver; end

  def show
    @user = User.find(params[:id])
  end
end

# frozen_string_literal: true

# Controller for model Carpool
class CarpoolsController < ApplicationController
  before_action :set_carpool, only: %i[show edit update delete user_leave chatroom toggle_open_for_request notify_covid]
  before_action :set_lists, only: %i[index show my_rides edit new_from_campus new_to_campus create]
  before_action :authenticate_user!, except: [:index]

  def user_leave
    UserInCarpool.destroy_by(user_id: current_user.id, carpool_id: @carpool.id)
    @carpool.update(open_spots: @carpool.open_spots + 1)
    request = Request.find_by(user_id: current_user.id, carpool_id: @carpool.id)
    request.update(result: 'Removed')
    Notification.create(user_id: @carpool.driver.user.id, message: "#{current_user.name} has left your carpool #{@carpool.summary}", carpool_id: @carpool.id)
    flash[:alert] = 'You were succesfully removed from the carpool'
    redirect_to carpool_path(@carpool)
  end

  def toggle_open_for_request
    if @carpool.open_for_request
      @carpool.update(open_for_request: false)
    else
      @carpool.update(open_for_request: true)
    end
    redirect_to carpool_path(@carpool)
  end

  def notify_covid
    @message = "ALERT COVID!!! An user you shared the carpool #{@carpool.summary} has COVID. 
    Please take precautionary measures and get your self tested"
    @carpool.users.each do |user|
      if user.id != current_user.id
        Notification.create(user_id: user.id, message: @message, carpool_id: @carpool.id)
      end
    end
    if @carpool.driver.user.id != current_user.id
      Notification.create(user_id: @carpool.driver.user.id, message: @message, carpool_id: @carpool.id)
    end
    flash[:alert] = "You have succesfully warned the other passengers, thank you!"
    redirect_to carpool_path(@carpool)
  end

  def index
    @min_date = Date.today
    @min_stars = "1"
    @open = Carpool.all.map{|carpool| carpool.id if (!carpool.completed? and carpool.open_for_request)}
    @carpools = Carpool.where(id: @open)
    if params[:carpool]
      @params = params[:carpool]
      @from_location = @params[:from_location]
      @to_location = @params[:to_location]
      @from_to = @params[:from_to]
      @min_date = @params[:min_date]
      @max_date = @params[:max_date]
      @min_stars = @params[:min_stars].to_i
      @sort_by = @params[:sort_by]
      @carpools = @carpools.where('LOWER(from_location) LIKE ?', "%#{@from_location.downcase}%")
      @carpools = @carpools.where('LOWER(to_location) LIKE ?', "%#{@to_location.downcase}%")
      if not @from_to == "From/To"
        @carpools = @carpools.where(type_of_ride: @from_to)
      end
      @carpools = @carpools.where('date >= ?', @min_date)
      if @max_date==''
        @carpools = @carpools.where('date <= ?', Date.today+4.years)
      else
        @carpools = @carpools.where('date <= ?', @max_date)
      end
      @good_review = @carpools.map{|carpool| carpool.id if carpool.driver.user.driver_average_rating >= @min_stars}
      @carpools = @carpools.where(id: @good_review)
    end
    if @sort_by != "Last to Soonest"
      @carpools = @carpools.order(:date, :time_of_departure)
    else
      @carpools = @carpools.order('date DESC')
    end
  end

  def show
    @requests = @carpool.requests.where(result: 'Waiting')
    @description = if @carpool.type_of_ride == 'From Campus'
                     'Drop off location'
                   else
                     'Pick up location'
                   end
    @users_in_carpool = @carpool.users
  end

  def user_rides
    @user = User.find(params[:id])
    @carpools = if @user.driver.nil?
                  []
                else
                  @user.driver.carpools
                end
  end

  def rides_im_in
    @carpools = current_user.carpools
  end

  def chatroom; end

  def new
    @carpool = Carpool.new
  end

  def new_from_campus
    @from = @campus
    @to = @comunes
    @description = 'Drop off location'
  end

  def new_to_campus
    @from = @comunes
    @to = @campus
    @description = 'Pick up location'
  end

  def create
    @carpool = Carpool.new(carpool_params)
    @carpool.update(open_for_request: true)
    if @carpool.save
      @carpool.type_of_ride = if @campus.include? @carpool.from_location
                                'From Campus'
                              else
                                'To Campus'
                              end
      @carpool.driver_id = current_user.id
      @carpool.save
      flash[:alert] = 'Your Carpool was succesfully created!'
      redirect_to carpool_path(@carpool)
    else
      render 'new'
    end
  end

  def edit
    if @carpool.type_of_ride == 'From Campus'
      @from = @campus
      @to = @comunes
      @selected_from = @carpool.from_location
      @selected_to = @carpool.to_location
      @description = 'Drop off location'
    else
      @from = @comunes
      @to = @campus
      @selected_from = @carpool.to_location
      @selected_to = @carpool.from_location
      @description = 'Pick up location'
    end
  end
  
  def update
    @carpool.users.each do |user|
      Notification.create(user_id: user.id, message: "Carpool #{@carpool.summary} was edited by #{@carpool.driver.user.name}", carpool_id: @carpool.id)
    end
    
    if @carpool.update(carpool_params)
      redirect_to carpool_path(@carpool)
    else
      render 'edit'
    end
  end

  def delete
    @carpool.users.each do |user|
      Notification.create(user_id: user.id, message: "#{@carpool.driver.user.name} has deleted the carpool you were in #{@carpool.summary}", carpool_id: @carpool.id)
    end
    @carpool.destroy
    redirect_to carpools_index_path
  end

  private

  def set_lists
    @campus = ['San Joaquin', 'Casa Central', 'Campus Oriente', 'Lo Contador']

    @comunes = ['Santiago', 'Conchalí',
                'Huechuraba', 'Independencia', 'Quilicura', 'Recoleta', 'Renca', 'Las Condes',
                'Lo Barnechea', 'Providencia', 'Vitacura', 'La Reina', 'Macul', 'Ñuñoa', 'Peñalolén',
                'La Florida', 'La Granja', 'El Bosque', 'La Cisterna', 'La Pintana', 'San Ramón',
                'Lo Espejo', 'Pedro Aguirre Cerda', 'San Joaquín', 'San Miguel', 'Cerrillos',
                'Estación Central', 'Maipú', 'Cerro Navia', 'Lo Prado', 'Pudahuel', 'Quinta Normal', 'Otro']

    @hours = ['6:00', '6:30', '7:00', '7:30', '8:00', '8:30', '9:00', '9:30', '10:00', '10:30',
              '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00',
              '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30',
              '20:00', '20:30', '21:00', '21:30', '22:00', '22:30']
  end

  def set_carpool
    @carpool = Carpool.find(params[:id])
  end

  def carpool_params
    params.require(:carpool).permit(:from_location, :dropoff_pickup, :date, :time_of_departure, :price, :open_spots,
                                    :to_location)
  end
end

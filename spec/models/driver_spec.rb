
require 'rails_helper'

RSpec.describe Driver, type: :model do
  before(:each) do
    @user = User.create!(name: 'testuser', email: 'a@a.com', password: '123456', password_confirmation: '123456', phone: '123456', description: '123456', address: '123456')
    @driver = Driver.new(user_id: @user.id, driver_license_number: '123456', license_plate: '123456', car_description: 'Blue car')
  end

  it 'is valid with valid attributes' do
    expect(@driver).to be_valid
  end

  it 'is not valid with a short license plate' do
    @driver.license_plate = '123'
    expect(@driver).not_to be_valid
  end

  it 'is not valid with a long license plate' do
    @driver.license_plate = '123456789'
    expect(@driver).not_to be_valid
  end

  it 'is not valid with no driver license number' do 
    @driver.driver_license_number = nil
    expect(@driver).not_to be_valid
  end

  it 'is not valid with no license plate' do
    @driver.license_plate = nil
    expect(@driver).not_to be_valid
  end
  
  it 'is not valid with no car description' do
    @driver.car_description = nil
    expect(@driver).not_to be_valid
  end

  describe 'nice license plate' do
    it 'gives back the nice license plate' do
      expect(@driver.nice_license_plate).to eq("12-34-56")
    end
  end
  
  describe 'current_carpools' do
    it 'return an empty list if driver has no carpools' do
      expect(@driver.current_carpools).to eq([])
    end

    it 'returns a list with the carpool the user has created' do
      @carpool = Carpool.create!(driver_id: @driver.user.id, from_location: 'Lo Barnechea', to_location: 'San Joaquin', dropoff_pickup: 'Mall Vivo',
                           date: Date.tomorrow, time_of_departure: '8:00', price: 500,
                           open_spots: 3, type_of_ride: 'To Campus', open_for_request: true)
      expect(@driver.current_carpools).to eq([@carpool])
    end
  end
  describe 'closed carpools' do 
    it 'returns an empty list if the user has not any completed carpools' do
      @carpool = Carpool.create!(driver_id: @driver.user.id, from_location: 'Lo Barnechea', to_location: 'San Joaquin', dropoff_pickup: 'Mall Vivo',
                           date: Date.tomorrow, time_of_departure: '8:00', price: 500,
                           open_spots: 3, type_of_ride: 'To Campus', open_for_request: true)
      expect(@driver.closed_carpools).to eq([])
    end
  end
end


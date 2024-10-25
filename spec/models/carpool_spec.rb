require 'rails_helper'

RSpec.describe Carpool, type: :model do
  before(:each) do
    @carpool = Carpool.new(driver_id: 2, from_location: 'Lo Barnechea', to_location: 'San Joaquin', dropoff_pickup: 'Mall Vivo',
                           date: Date.tomorrow, time_of_departure: '8:00', price: 500,
                           open_spots: 3, type_of_ride: 'To Campus', open_for_request: true)
  end

  it 'is valid with valid attributes' do
    expect(@carpool).to be_valid
  end

  it 'is not valid with negative price' do
    @carpool.price = -2000
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with price to expensive' do
    @carpool.price = 3000
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with a dropoff_pickup too short' do
    @carpool.dropoff_pickup = 'asd'
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with a dropoff_pickup too long' do
    @carpool.dropoff_pickup = 'sitehefalladotepidoperdondelaunicaformaquese'
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with date before today' do
    @carpool.date = Date.yesterday - 1.day
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with no from location' do
    @carpool.from_location = nil
    expect(@carpool).not_to be_valid
  end

  it 'is not valid with too many open spots' do
    @carpool.open_spots = 13
    expect(@carpool).not_to be_valid
  end
end

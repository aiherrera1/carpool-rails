

require 'rails_helper'

RSpec.describe 'Request', type: :system do
  before do
    DatabaseCleaner.strategy=:transaction
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  it 'is able to create a request and cancel it' do
    #user 1 is driver and owner of carpool
    # user 2 will see that carpool, create a request, cancel that request
    @user1   = User.create!(email: '1@user.com', password: '123456', password_confirmation: '123456', name: 'user1', phone: '9999999991', address: "road1", description: 'imuser1', admin: false)
    @user2   = User.create!(email: '2@user.com', password: '123456', password_confirmation: '123456', name: 'user2', phone: '9999999992', address: "road2", description: 'imuser2', admin: false)
    @user3   = User.create!(email: '3@user.com', password: '123456', password_confirmation: '123456', name: 'user3', phone: '9999999993', address: "road3", description: 'imuser3', admin: false)
    @driver1 = Driver.create!(user_id: @user1.id, driver_license_number: "123456", license_plate: "123456", car_description: "red car")
    @carpool = Carpool.create!(driver_id: @user1.id, date:Date.tomorrow, time_of_departure: "6:00", price: 0, open_spots: 2, type_of_ride: "To Campus", open_for_request:true, from_location: "San Joaquin", to_location: "Santiago", dropoff_pickup: "Metro tobalaba" )     
    visit '/login'
    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: @user2.password
    click_button 'Log in'
    visit "/carpool/#{@carpool.id}"
    click_link "Request"
    click_link "Cancel Request"
  end

  it 'is able to accept a request, reject a request, and remove someone from carpool' do
    @user1   = User.create!(email: '1@user.com', password: '123456', password_confirmation: '123456', name: 'user1', phone: '9999999991', address: "road1", description: 'imuser1', admin: false)
    @user2   = User.create!(email: '2@user.com', password: '123456', password_confirmation: '123456', name: 'user2', phone: '9999999992', address: "road2", description: 'imuser2', admin: false)
    @user3   = User.create!(email: '3@user.com', password: '123456', password_confirmation: '123456', name: 'user3', phone: '9999999993', address: "road3", description: 'imuser3', admin: false)
    @driver1 = Driver.create!(user_id: @user1.id, driver_license_number: "123456", license_plate: "123456", car_description: "red car")
    @carpool = Carpool.create!(driver_id: @user1.id, date:Date.tomorrow, time_of_departure: "6:00", price: 0, open_spots: 2, type_of_ride: "To Campus", open_for_request:true, from_location: "San Joaquin", to_location: "Santiago", dropoff_pickup: "Metro tobalaba" )     
    @request_user2 = Request.create!(carpool_id: @carpool.id, user_id: @user2.id, result: 'Waiting')
    @request_user3 = Request.create!(carpool_id: @carpool.id, user_id: @user3.id, result: 'Waiting')
    visit '/login'
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'
    visit "/carpool/#{@carpool.id}"
    first(:link, 'Accept').click
    click_link 'Reject'
    click_link 'Remove'
    #
  end

  after do
    DatabaseCleaner.clean
  end
end
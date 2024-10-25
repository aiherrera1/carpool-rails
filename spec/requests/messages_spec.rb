require 'rails_helper'

RSpec.describe 'Message', type: :system do
  before do
    DatabaseCleaner.strategy=:transaction
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  it 'is able send a message' do
    @user1   = User.create!(email: '1@user.com', password: '123456', password_confirmation: '123456', name: 'user1', phone: '9999999991', address: "road1", description: 'imuser1', admin: false)
    @user2   = User.create!(email: '2@user.com', password: '123456', password_confirmation: '123456', name: 'user2', phone: '9999999992', address: "road2", description: 'imuser2', admin: false)
    @driver1 = Driver.create!(user_id: @user1.id, driver_license_number: "123456", license_plate: "123456", car_description: "red car")
    @carpool = Carpool.create!(driver_id: @user1.id, date:Date.today, time_of_departure: "1:00", price: 0, open_spots: 2, type_of_ride: "To Campus", open_for_request:true, from_location: "San Joaquin", to_location: "Santiago", dropoff_pickup: "Metro tobalaba" )     
    @user_in_carpool = UserInCarpool.create!(user_id: @user2.id, carpool_id: @carpool.id)
    visit '/login'
    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: @user2.password
    click_button 'Log in'
    visit "/message/new/#{@carpool.id}"
    fill_in "message[message_text]", with:  "hola"
    click_button "commit"
  end


  after do
    DatabaseCleaner.clean
  end
end
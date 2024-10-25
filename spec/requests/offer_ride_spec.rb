
require 'rails_helper'

RSpec.describe 'Offer a Carpool', type: :system do
  before do
    DatabaseCleaner.strategy=:transaction
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end
  before(:each) {
    @attr_user = {
      :email => 'test@user.com',
      :password => "123456",
      :password_confirmation => '123456',
      :name => 'test user',
      :phone => '4567893245',
      :address => 'Road 123',
      :description => 'Hi this is my description',
      :admin => false
    }
  }

  it 'is able to offer a ride from campus' do
    @user = User.create!(@attr_user)
    visit '/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit "/drivers/new"
    fill_in "Driver license number", with: "123456"
    fill_in "License plate", with: "DCC123"
    fill_in "Car description", with: "Blue car"
    click_button "Register"
    # expect(page).to have_content("You were successfully registered as driver!")
    click_link 'Offer a ride'
    click_link 'From Campus'
    fill_in 'carpool[dropoff_pickup]', with: 'metro tobalaba'
    click_button 'Save Carpool'
  end

  it 'is able to offer a ride to campus' do
    @user = User.create!(@attr_user)
    visit '/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit "/drivers/new"
    fill_in "Driver license number", with: "123456"
    fill_in "License plate", with: "DCC123"
    fill_in "Car description", with: "Blue car"
    click_button "Register"
    # expect(page).to have_content("You were successfully registered as driver!")
    click_link 'Offer a ride'
    click_link 'To Campus'
    fill_in 'carpool[dropoff_pickup]', with: 'metro tobalaba'
    click_button 'Save Carpool'
  end

  it ' is able to close and open for request, and delete it after' do
    @user = User.create!(@attr_user)
    @driver = Driver.create!(user_id: @user.id, driver_license_number:'4564376', license_plate:'155438', car_description: 'blue car')
    visit '/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    click_link 'Offer a ride'
    click_link 'To Campus'
    fill_in 'carpool[dropoff_pickup]', with: 'metro tobalaba'
    fill_in 'Date', with: Date.tomorrow
    click_button 'Save Carpool'
    click_link 'Close for request'
    click_link 'Open for request'
    click_link 'Delete Carpool'
  end

  after do
    DatabaseCleaner.clean
  end
end
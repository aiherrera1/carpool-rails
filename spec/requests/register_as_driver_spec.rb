require 'rails_helper'

RSpec.describe 'Register as Driver', type: :system do
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

  it 'sucesssfully register as driver' do
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
  end

  after do
    DatabaseCleaner.clean
  end
end
# admin can see dashboardRegister as Driver
require 'rails_helper'

RSpec.describe 'Admin', type: :system do
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
      :admin => true
    }
  }

  it 'can see admin dashboard' do
    @user = User.create!(@attr_user)
    visit '/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit '/admin'
    click_link 'Users'
    click_link 'Drivers'
    click_link 'Requests'
    click_link 'Reviews'  
    click_link 'Carpools'
    click_link 'Back to app'
    
  end

  after do
    DatabaseCleaner.clean
  end
end
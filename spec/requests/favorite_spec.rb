require 'rails_helper'

RSpec.describe 'Favorite', type: :system do
  before do
    DatabaseCleaner.strategy=:transaction
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  it 'is able to add and remove another user from favorites' do
    @user1   = User.create!(email: '1@user.com', password: '123456', password_confirmation: '123456', name: 'user1', phone: '9999999991', address: "road1", description: 'imuser1', admin: false)
    @user2   = User.create!(email: '2@user.com', password: '123456', password_confirmation: '123456', name: 'user2', phone: '9999999992', address: "road2", description: 'imuser2', admin: false)
    visit '/login'
    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: @user2.password
    click_button 'Log in'
    visit "/home/#{@user1.id}"
    click_link "Add to favorites"
    visit "/home/favorites"
    visit "/home/favorites"
    visit "/home/favorites"
    click_link "Remove From Favorites"
  end

  after do
    DatabaseCleaner.clean
  end
end
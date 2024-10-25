require 'rails_helper'

RSpec.describe 'Sign Up/Log Out/Log In', type: :system do
 before do
   DatabaseCleaner.strategy=:transaction
   DatabaseCleaner.clean_with(:truncation)
   DatabaseCleaner.start
 end
  it 'sucesssfully sign_up and login' do
    visit '/register'
    fill_in "Email",    with: "newuser@gmail.com"
    fill_in "Name",    with: "juan"
    fill_in "Phone", with: "123456"
    fill_in "Address",    with: "hola" 
    fill_in "Description",    with: "me llamo juan"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"
    # expect(page).to have_content("Welcome!")
    click_link "Juan"
    click_link "Log Out"
    # expect(page).to have_content("Signed out successfully.") 
    visit '/login'
    fill_in "Email",    with: "newuser@gmail.com"
    fill_in "Password", with: "123456"
    click_button "Log in"
    # expect(page).to have_content("Signed in successfully.")
  end

 after do
   DatabaseCleaner.clean
 end
end
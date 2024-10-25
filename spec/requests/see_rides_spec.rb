require 'rails_helper'

RSpec.describe 'See Rides', type: :system do
  it 'sucesssfully see rides' do
    visit '/carpools/index'
    fill_in 'carpool[from_location]', with: "San"
    click_button 'Apply Filters'
    expect(page).to have_content("Available Carpools")
 end
end
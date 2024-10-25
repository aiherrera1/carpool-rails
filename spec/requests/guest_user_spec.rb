require 'rails_helper'

RSpec.describe 'Guest', type: :system do
  it 'can see carpools as guest' do
    visit '/home/guest'
    expect(page).to have_content("Guest user view")
 end
end
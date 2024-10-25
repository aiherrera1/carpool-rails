require 'rails_helper'

RSpec.describe "Carpools", type: :request do
  include CarpoolsHelper
  describe 'Price is multiple of 500' do
    it 'should return true' do
      expect(price_de_quina(1500)).to eq(true)
    end
  end
  
end

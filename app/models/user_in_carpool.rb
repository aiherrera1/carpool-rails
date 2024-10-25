# frozen_string_literal: true

class UserInCarpool < ApplicationRecord
  belongs_to :user # UserInCarpool associated via 'user_id' on UserInCarpool table
  belongs_to :carpool # UserInCarpool associated via 'carpool_id' on UserInCarpool table
end

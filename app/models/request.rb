# frozen_string_literal: true

# Model for Request
class Request < ApplicationRecord
  belongs_to :user
  belongs_to :carpool
end

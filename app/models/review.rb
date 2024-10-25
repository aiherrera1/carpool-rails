# frozen_string_literal: true

# Model for Review
class Review < ApplicationRecord
  validates :stars, numericality: { only_integer: true }

  belongs_to :carpool
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'
end

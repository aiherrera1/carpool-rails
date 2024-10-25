# frozen_string_literal: true

# Model for Favorite
class Favorite < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :favorite_user, class_name: 'User', foreign_key: 'favorite_user_id'
end

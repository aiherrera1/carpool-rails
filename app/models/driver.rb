# frozen_string_literal: true

# Model Driver
class Driver < ApplicationRecord
  validates :driver_license_number, presence: true
  validates :license_plate, presence: true, length: { minimum: 6 }
  validates :license_plate, presence: true, length: { maximum: 6 }
  validates :car_description, presence: true

  belongs_to :user, foreign_key: 'user_id'
  has_many :carpools, foreign_key: 'driver_id', primary_key: 'user_id', dependent: :destroy

  def current_carpools
    carpools = []
    self.carpools.each do |carpool|
      carpools.push(carpool) unless carpool.completed?
    end
    carpools
  end

  def closed_carpools
    carpools = []
    self.carpools.each do |carpool|
      carpools.push(carpool) if carpool.completed?
    end
    carpools
  end

  def nice_license_plate
    license_plate.upcase.chars.each_slice(2).map(&:join).join('-')
  end
end

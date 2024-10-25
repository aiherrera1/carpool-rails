# frozen_string_literal: true

# Model for Carpool
class Carpool < ApplicationRecord
  validates :date, inclusion: { in: (Date.today..Date.today + 5.years) }
  validates :from_location, presence: true
  validates :dropoff_pickup, presence: true, length: { minimum: 5 }
  validates :dropoff_pickup, presence: true, length: { maximum: 40 }
  validates :time_of_departure, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { less_than_or_equal_to: 2500 }
  validates :open_spots, numericality: { greater_than_or_equal_to: 0 }
  validates :open_spots, numericality: { less_than_or_equal_to: 10 }
  validates :open_spots, numericality: { only_integer: true }
  validates :to_location, presence: true

  has_one :driver, foreign_key: 'user_id', primary_key: 'driver_id'
  has_many :requests, dependent: :destroy
  has_many :user_in_carpools
  has_many :users, through: :user_in_carpools # carpool.users returns all users in that carpool
  has_many :messages, dependent: :destroy
  has_many :reviews
  has_many :notifications

  def summary
    "#{from_location}-#{to_location}, #{date_time.strftime('%A %B %d')}"
  end

  def date_time
    hour, minutes = time_of_departure.split(':')
    DateTime.new(date.year, date.month, date.day, hour.to_i, minutes.to_i, 0, Rational(-4, 24))
  end

  def covid?
    notifications.each do |notification|
      return true if notification.message.include? 'COVID'
    end
    false
  end

  def completed?
    return unless date_time <= DateTime.now

    update(open_for_request: false)
    true
  end

  def open_for_chat
    date_time - 1.day <= DateTime.now
  end

  # an user can review another user, if they are not the same user and if the user reviewing is in the carpool
  def can_review(from_user, to_user)
    unless (from_user != to_user) && ((users.where(id: from_user.id).count == 1) || (from_user.id == driver.user.id))
      return
    end

    reviews.where(from_user_id: from_user.id, to_user_id: to_user.id).count.zero?
  end
end

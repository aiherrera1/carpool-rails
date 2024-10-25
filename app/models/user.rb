# frozen_string_literal: true

# Class del modelo User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :phone, :address, :description, presence: true

  has_one :driver, dependent: :destroy
  has_many :requests, dependent: :destroy

  has_many :user_in_carpools
  has_many :carpools, through: :user_in_carpools # carpools he is in
  has_many :favorites, dependent: :destroy

  has_many :messages
  has_many :made_reviews, class_name: 'Review', foreign_key: 'from_user_id'
  has_many :reviews, foreign_key: 'to_user_id'

  has_many :notifications, dependent: :destroy
  has_many :reports, class_name: 'Report', foreign_key: 'to_user_id', dependent: :destroy

  has_one_attached :avatar

  def favorite?(user)
    Favorite.find_by(user_id: id, favorite_user_id: user.id)
  end

  def current_carpools
    carpools = []
    self.carpools.each do |carpool|
      carpools.push(carpool) unless carpool.completed?
    end
    driver&.carpools&.each do |carpool|
      carpools.push(carpool) unless carpool.completed?
    end
    carpools
  end

  def closed_carpools
    carpools = []
    self.carpools.each do |carpool|
      carpools.push(carpool) if carpool.completed?
    end
    driver&.carpools&.each do |carpool|
      carpools.push(carpool) if carpool.completed?
    end
    carpools
  end

  def open_chatrooms
    carpools = []
    self.carpools.each do |carpool|
      carpools.push(carpool) if carpool.open_for_chat
    end
    driver&.carpools&.each do |carpool|
      carpools.push(carpool) if carpool.open_for_chat
    end
    carpools
  end

  def carpool_request(carpool)
    Request.where(user_id: id, carpool_id: carpool)
  end

  def in_carpool(carpool)
    return true if carpool.driver.user_id == id

    UserInCarpool.where(carpool_id: carpool.id, user_id: id).count == 1
  end

  def request_status(carpool)
    request = Request.find_by(user_id: id, carpool_id: carpool)
    if request
      request.result
    else
      'None'
    end
  end

  def user_request(carpool)
    Request.find_by(user_id: id, carpool_id: carpool)
  end

  def average_rating
    list = []
    reviews.each do |review|
      list.push(review.stars)
    end
    return 5 if list.size.zero?

    (list.sum(0.0) / list.size).to_i
  end

  def passenger_average_rating
    list = []
    reviews.each do |review|
      list.push(review.stars) if review.type_of_review == 'To Passenger'
    end
    return 5 if list.size.zero?

    (list.sum(0.0) / list.size).to_i
  end

  def driver_average_rating
    list = []
    reviews.each do |review|
      list.push(review.stars) if review.type_of_review == 'To Driver'
    end
    return 5 if list.size.zero?

    (list.sum(0.0) / list.size).to_i
  end
end

# frozen_string_literal: true

require 'administrate/base_dashboard'

class CarpoolDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    driver: Field::HasOne,
    requests: Field::HasMany,
    user_in_carpools: Field::HasMany,
    users: Field::HasMany,
    messages: Field::HasMany,
    reviews: Field::HasMany,
    id: Field::Number,
    driver_id: Field::Number,
    date: Field::Date,
    time_of_departure: Field::String,
    price: Field::Number,
    open_spots: Field::Number,
    type_of_ride: Field::String,
    open_for_request: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    from_location: Field::String,
    to_location: Field::String,
    dropoff_pickup: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    driver
    requests
    user_in_carpools
    users
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    driver
    requests
    user_in_carpools
    users
    messages
    reviews
    id
    driver_id
    date
    time_of_departure
    price
    open_spots
    type_of_ride
    open_for_request
    created_at
    updated_at
    from_location
    to_location
    dropoff_pickup
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    driver
    requests
    user_in_carpools
    users
    messages
    reviews
    driver_id
    date
    time_of_departure
    price
    open_spots
    type_of_ride
    open_for_request
    from_location
    to_location
    dropoff_pickup
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how carpools are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(carpool)
  #   "Carpool ##{carpool.id}"
  # end
end

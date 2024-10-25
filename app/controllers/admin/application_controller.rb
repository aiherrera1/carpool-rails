# frozen_string_literal: true

# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  # Application controller for admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!

    # def authenticate_admin
    #   # TODO Add authentication logic here.
    # end

    def authenticate_user!
      return if current_user&.admin?

      redirect_to root_path, notice: 'You are not an admin'
    end
    # https://stackoverflow.com/questions/15198677/authenticate-using-devise-and-rails-admin-for-particular-routes
    # https://stackoverflow.com/questions/31892058/how-to-set-an-user-as-admin-rails
    # https://stackoverflow.com/questions/16052352/how-to-allow-only-admin-or-some-user-to-edit-the-pages-in-rails

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end

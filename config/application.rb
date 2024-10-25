# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Grupo44software
  # Class Application that configures Rails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # Added for RSpec
    config.generators do |gen|
      gen.test_framework :rspec, fixture: true
      gen.fixture_replacement :factory_girl, dir: 'spec/factories'

      # Do not generate RSpecs test for views
      gen.view_specs false
      gen.helper_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

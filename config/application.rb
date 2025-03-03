require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

require_relative '../lib/custom_formatter'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EspertoFitAcademy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.payment = config_for(:payment).symbolize_keys
    config.time_zone = 'America/Sao_Paulo'
    config.active_record.default_timezone = :local

    config.active_record.belongs_to_required_by_default = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.esperto_fit_personal = config_for(:academy).symbolize_keys
    config.esperto_fit_payment = config_for(:academy).symbolize_keys


    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("lib")

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://esperto_fit_academy_web_run_1'
        resource '/api/v1/*',
          headers: %w(Authorization),
          methods: :any,
          expose: ["Authorization", "jti"],
          max_age: 600
      end
    end
  end

  
end

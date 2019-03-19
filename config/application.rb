# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjObsSocial
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.time_zone = 'Brasilia'

    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'
    end
end

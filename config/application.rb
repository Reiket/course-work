require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module CourseWork
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.available_locales = %i[uk]
    config.i18n.default_locale = :uk

    config.time_zone = 'Europe/Kiev'
  end
end

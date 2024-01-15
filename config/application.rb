require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module JerichoBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.autoload_paths += %W(#{config.root}/app/services)

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          methods: [:get, :post, :options, :delete, :put]
      end
    end

    config.api_only = true
  end
end

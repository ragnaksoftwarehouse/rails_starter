require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoreApps
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    
    config.autoload_paths += Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'errors', '*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'core', '*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'app', '*.rb')]

    config.autoload_paths += Dir[Rails.root.join('app', 'controllers', '{*/}')]

    config.eager_load_paths += Dir[Rails.root.join('app', 'services', '*.rb')]
    config.eager_load_paths += Dir[Rails.root.join('app', 'presenters', '*.rb')]

    directory_name = Rails.root.join('uploads')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)

    config.session_store :redis_store, {
        servers: [{
            host: "localhost",
            port: 6379,
            db: 0,
            password: "mysecret",
            namespace: "session"
        }],
        expire_after: 90.minutes
    }
  end
end

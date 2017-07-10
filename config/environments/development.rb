Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  config.assets.precompile += %w( .svg .eot .woff .ttf)

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.urls = {
    web: 'http://localhost:3000',
    app: 'http://app.autologger.dev'
  }
  config.action_mailer.raise_delivery_errors = true 
  
  # config.action_mailer.default_url_options = { :host => 'serwer1605860.home.pl' }
  # config.action_mailer.delivery_method = :smtp
  
  # options = { :address => 'serwer1605860.home.pl',
  #             :port => 465,
  #             :ssl => true,
  #             :domain => 'ragnak.com',
  #             :user_name => 'sender@ragnak.com',
  #             :password => 'u^XPsWx@zWQX',
  #             :authentication => :plain,
  #             :parts_order => %w(text/html text/enriched text/plain application/pdf),
  #             :enable_starttls_auto => true  }
# 6bb97281b92273720a4d59336ba0c937445cb48d
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    api_key: 'key-eef57f691c1e3249c9536b5394460407',
    domain: 'mg.autologger.eu'
  }
  config.default_mail_sender = "Ania <ania@autologger.eu>"

  # config.action_mailer.smtp_settings = options
  # Mail.defaults do  
  #   delivery_method :smtp, options
  # end

  config.react.variant = :development
end

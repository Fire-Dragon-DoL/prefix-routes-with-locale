module PrefixRoutesWithLocale
  class Railtie < Rails::Railtie

    config.prefix_routes_with_locale = ActiveSupport::OrderedOptions.new
    config.prefix_routes_with_locale.use_http_locale_accept_language = true
    config.prefix_routes_with_locale.auto_set_locale = true
  
  end
end
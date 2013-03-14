module PrefixRoutesWithLocale
  module ActionDispatch
    module MapperMethods
    
      # All routes in this method block will be prefixed, put what you don't want to be
      # prefixed, outside of this method. You can pass optionally a parameter to the method,
      # the parameter is a list of available locales, otherwise set from I18n.available_locales
      def prefix_routes_with_locale(locale_list = false)
        available_locales = I18n.available_locales
        available_locales = locale_list if locale_list
        
        scope ":locale", locale: /#{available_locales.join("|")}/ do
          yield
        end
      end

      # Use this method as the last one in your routes, will ensure that any path contains the url prefix,
      # is optional.
      def ensure_url_has_locale
        match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
        match '', to: redirect("/#{I18n.default_locale}")
      end
    
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, PrefixRoutesWithLocale::ActionDispatch::MapperMethods
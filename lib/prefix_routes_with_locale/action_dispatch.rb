module PrefixRoutesWithLocale
  module ActionDispatch
    module MapperMethods
    
      def prefix_routes_with_locale
        scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
          yield
        end
      end

      def ensure_url_has_locale
        match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
        match '', to: redirect("/#{I18n.default_locale}")
      end
    
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, RailsI18nRoutes::ActionDispatch::MapperMethods
module PrefixRoutesWithLocale
  module ActionController
    module BaseMethods
      
      def self.included(base)
        base.send(:prepend_before_filter, :set_locale_from_prefix_or_suppose)
      end

      def default_url_options
        self.prefix_routes_with_locale_default_url_options.merge({locale: I18n.locale})
      end

      # Set I18n.locale, based on the given priority: url prefix/session/http/default_locale.
      # When the locale is found, session[:locale] is set to that value
      def set_locale_from_prefix_or_suppose
        return unless Rails.application.config.prefix_routes_with_locale.auto_set_locale
        
        # Find out preferred locale from HTTP header
        preferred_locales = I18n.available_locales

        http_locale = I18n.default_locale
        if defined?(http_accept_language) && !http_accept_language.nil?
          http_locale = http_accept_language.compatible_language_from(preferred_locales)
        end

        # Set locale based on user preference or try to suppose it
        if session.present?
          I18n.locale = params[:locale] || session[:locale] || http_locale || I18n.default_locale
        else
          I18n.locale = params[:locale] || http_locale || I18n.default_locale
        end

        # Update user preferred locale based on what it uses
        session_locale_is_set = session.present? && session[:locale]
        session_locale_is_set &&= session[:locale] == params[:locale]

        # Update session with chosen locale only if different
        session[:locale] = I18n.locale unless session_locale_is_set
      end
      
    end
  end
end

ActionController::Base.send(:alias_method, :prefix_routes_with_locale_default_url_options, :default_url_options)
ActionController::Base.send(:remove_method, :default_url_options)
ActionController::Base.send(:include, PrefixRoutesWithLocale::ActionController::BaseMethods)
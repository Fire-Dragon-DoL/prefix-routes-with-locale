module PrefixRoutesWithLocale
  module ActionController
    module BaseMethods
      
      def self.included(base)
        base.send :prepend_before_filter, :set_locale_from_prefix_or_suppose
        base.send :default_url_options, :default_url_options
      end
      
      protected

        # Set I18n.locale, based on the given priority: url prefix/session/http/default_locale.
        # When the locale is found, session[:locale] is set to that value
        def set_locale_from_prefix_or_suppose
          return if Rails.application.config.prefix_routes_with_locale.auto_set_locale
          
          # Find out preferred locale from HTTP header
          preferred_locales = I18n.available_locales

          http_locale = I18n.default_locale
          if Rails.application.config.use_http_locale_accept_language && defined?(http_accept_language) && !http_accept_language.nil?
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

        def default_url_options
          super.merge({locale: I18n.locale})
        end
      
    end
  end
end

ActionController::Base.send :include, PrefixRoutesWithLocale::ActionController::BaseMethods
### Last update March 17 2013
The gem is currently not working as intended, I've difficulties handling url_for.
Use [Sven Fuchs Routing Filter](https://github.com/svenfuchs/routing-filter) at the
moment.

---

## Prefix Routes with Locale

Small gem to detect the locale from prefix, ensuring that is added to any route.
Set the locale based on prefix.

## Install

Put this line in your Gemfile:

    gem 'prefix-routes-with-url', github: 'Fire-Dragon-DoL/prefix-routes-with-locale'

You can optionally add this if you want locale set through http:

    gem 'http_accept_language', github: 'DouweM/http_accept_language', branch: 'no-middleware-no-crash'  
  
Then bundle:

    $ bundle  
  
## Usage

Remember to set I18n.available_locales in an initializer, to ensure you have an array of available locales.
Disable http_accept_language usage even when installed, if you want, in application.rb or initializer.
Disable the auto set locale, if you want to handle it by yourself, in application.rb or initializer .

Currently the locale is set with this priority in mind (higher to lower):

    url prefix > session[:locale] > http_accept_language > I18n.default_locale

To disable http_accept_language:

    config.prefix_routes_with_locale.use_http_locale_accept_language = false

To disable locale auto setting:

    config.prefix_routes_with_locale.auto_set_locale = false
  
Finally in your routes.rb pass the routes you want to be prefixed to prefix_routes_with_url method:

    prefix_routes_with_url do
      resources :news
      namespace :admin do
        resources :users
      end
      get 'pages#home'
    end

You can ensure that every time a url doesn't have the prefix, it will be added automatically.
Just ensure to run this method **out** of `prefix_routes_with_url`, after *any* route:

    YourApp::Application.routes.draw do
      prefix_routes_with_url do
        resources :news
        namespace :admin do
          resources :users
        end
        get 'pages#home'
      end
      ensure_url_has_locale
    end

## TODO

* Add some deeper tests (maybe with rails)
* Fix the issue witn ensure_url_has_locale (and rename it to ensure_route_has_prefix)
* Add some documentation

## Licensing
This gem is under MIT license, see LICENSE.txt file.

## Authors
* [Francesco Belladonna](https://github.com/Fire-Dragon-DoL)

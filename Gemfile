source 'https://rubygems.org'

gem 'http_accept_language', github: 'DouweM/http_accept_language', branch: 'no-middleware-no-crash'

group :development do
  gem 'bundler'
end

group :test do
  gem 'rspec'
  # Dependencies for guard
  gem 'guard-rspec' # Rerun tests when updated
  gem "factory_girl_rails" # Factory.create(:user) generate user from factory
  gem 'faker' # Random names
  gem 'database_cleaner'
end

group :development, :test do
  # Dependencies for guard
  gem 'rb-fsevent'
  gem 'wdm', "~> 0.0.3", platforms: [:mswin, :mingw], require: false 
  gem 'rb-inotify', '~> 0.8.8'
  gem 'fuubar' # Format guard in a nicer way
  gem 'spork' # Should improve performance of guard
  gem 'guard-spork'
  gem 'guard'

  gem 'sqlite3'
end
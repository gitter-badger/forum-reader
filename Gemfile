source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg',    '~> 0.19'
gem 'puma',  '~> 3.0'
gem 'redis-rails'
gem 'sidekiq'
gem 'clockwork'

gem 'exception_notification'
gem 'mina', '~> 1.0.0'
gem 'god'

gem 'sass-rails',    '~> 5.0'
gem 'uglifier',      '>= 1.3.0'
gem 'coffee-rails',  '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'                 # Build JSON APIs with ease
gem 'bcrypt',   '~> 3.1.7'               # Use ActiveModel has_secure_password

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'annotate'
  gem 'brakeman', require: false
  gem 'rdoc'
  gem 'rubocop', require: false

  gem 'web-console', '>= 3.3.0'          # <% console %> in views
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'vcr'
end

gem 'rails-i18n', '~> 5.0.0' # For 5.x
gem 'acts_as_list'
gem 'active_record_union'
gem 'feedjira'
gem 'blather'
gem 'em-http-request'
gem 'rchardet'

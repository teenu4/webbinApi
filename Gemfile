source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # A development utility to test GraphQL queries.
  gem 'graphiql-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# postgres db
gem 'pg'
# graphql api
gem 'graphql'
# cors to use non-rails clients
gem 'rack-cors'
# ActiveAdmin
gem 'activeadmin'
# image editing
gem 'image_processing'
gem 'mini_magick'
# advanced service objects
gem 'interactor', '~> 3.0'
# paging, filter, order, n+1 optimization for graphql
gem 'graphql-query-resolver'
gem 'search_object'
gem 'search_object_graphql'
gem 'graphql-batch'
gem 'graphql-preload', git: 'https://github.com/Envek/graphql-preload'

# amazon s3 files
gem "aws-sdk-s3", require: false

#auth
gem 'devise', '4.7.2'
gem 'devise-jwt', '0.8.0'
gem 'omniauth-google-oauth2'
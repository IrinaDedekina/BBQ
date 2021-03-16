source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.0.0'

gem 'rails', '~> 6.1.1'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'
gem 'mailjet'
gem 'pundit', '~> 2.1.0'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'letter_opener'
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'

  gem 'capistrano', '~> 3.10'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 2.0'
end

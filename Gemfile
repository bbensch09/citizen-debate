source 'https://rubygems.org'

gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#Bootstrap 4 via sprockets, stopped using this in attempt to fix glyphicons
# gem 'bootstrap', '~> 4.0.0.alpha3'

# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'

#loading FA via gem since CDN isn't seeming to work
gem 'font-awesome-sass'

#Use Tether (http://github.hubspot.com/tether/) for absolute positioning of tool tips, etc.
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

# One of the older AWS gem's was causing a compiler error...?
# gem "aws-s3"
# gem 'aws-sdk-v1'
# gem 'aws-sdk', '~> 2'
#AWS SDK's for storing images
gem 'aws-sdk-v1'
gem 'aws-sdk', '~> 2'

#Using CKeditor as the WYSIWYG editor for potential custom formatting in-line.
gem 'ckeditor'
#paperclip for file upload management
gem 'paperclip'

#Omniauth for eventual FB signup, NOT YET CONFIGURED WITH DEVISE
gem 'omniauth-facebook'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'faker'
gem 'hirb'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end


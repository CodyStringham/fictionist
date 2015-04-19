source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '4.2.0'
gem 'pg'
gem 'puma'

gem 'devise'
gem 'devise_invitable'
gem 'upmin-admin'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'foundation-rails'
gem 'font-awesome-rails'
gem 'masonry-rails'
gem 'mailboxer', :git => 'git://github.com/div/mailboxer.git', :branch => 'rails42-foreigner'

gem 'ffaker'

gem 'high_voltage'
gem 'simple_form'
gem 'figaro'
gem 'friendly_id'
# gem 'cocoon'
gem 'paperclip'

group :development do
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'meta_request'
  gem 'xray-rails'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'powder'
  gem 'annotate', '~> 2.6.5'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-minitest'
  gem 'guard-pow'
  # gem 'guard-livereload'
  # gem 'rack-livereload'
  gem 'ruby_gntp'
end

group :development, :test do
  gem 'jazz_fingers'
  gem 'web-console', github: 'rails/web-console', branch: 'master'
  gem 'rubocop'
  gem 'factory_girl_rails'
  gem 'minitest-rails'
end

group :test do
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

source "https://rubygems.org"

# Core framework
gem "rails", "~> 8.0.2"

# Database
gem "pg", "~> 1.5"

# Asset pipeline
gem "propshaft"

# Web server
gem "puma", ">= 5.0"

# JSON APIs
gem "jbuilder"

# Rails caching, queueing, and broadcasting
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Faster boot times
gem "bootsnap", require: false

# Deployment
gem "kamal", require: false

# Puma performance tuning
gem "thruster", require: false

# Timezones (for Windows)
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "pry"

  # Testing
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails"

  # Environment variables
  gem "dotenv-rails"

  # Security/linting
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "webmock"
  gem "vcr"
  gem "faker"
end

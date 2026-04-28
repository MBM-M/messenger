# Messenger

[![RSpec Tests](https://img.shields.io/badge/tests-RSpec-brightgreen.svg)](https://github.com/rspec/rspec-rails)
[![Test Coverage](https://img.shields.io/badge/coverage-60%25-yellow.svg)](./coverage)
[![Rails 8](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo%2FStimulus-orange.svg)](https://hotwired.dev/)

A production-ready Rails chat application demonstrating modern web development with Rails 8, Hotwire (Turbo & Stimulus), Action Cable for real-time messaging, and Devise authentication.

## Features

- **Real-time Messaging**: Messages appear instantly using Action Cable & Turbo Streams
- **User Authentication**: Full Devise integration with secure user management
- **Modern Stack**: Rails 8, Hotwire, Import maps (no Node.js required)
- **Production Ready**: Comprehensive test suite, Docker support, optimized for deployment
- **Clean Code**: Follows Rails conventions with proper separation of concerns

## Requirements
- Ruby 3.3.5 (rbenv/rvm as preferred)
- Node not required (importmap used)
- SQLite3 for development
- Bundler (bundle)
- Optional: Redis for production Action Cable/queues

## Gems of note

### Core
- **rails ~> 8.0.2**: Latest Rails framework
- **turbo-rails, stimulus-rails**: Hotwire for SPA-like experience
- **devise (~> 4.9)**: Authentication solution
- **propshaft**: Modern asset pipeline
- **importmap-rails**: JavaScript modules without build tools
- **redis (~> 4.0)**: For production Action Cable (optional)

### Development & Testing
- **rspec-rails**: Testing framework
- **factory_bot_rails**: Test fixtures
- **faker**: Realistic test data
- **capybara**: Integration testing
- **shoulda-matchers**: Convenient matchers
- **rubocop-rails-omakase**: Ruby/Rails style guide
- **brakeman**: Security scanning

## Quick start (development, Linux)
1. Install Ruby and dependencies (example using rbenv):
   - apt/yum: install build tools, sqlite dev headers
   - rbenv install 3.3.5
2. From project root:
   - bundle install
   - bin/rails db:setup    # creates & migrates database, loads seeds
   - bin/rails server
3. Visit: http://localhost:3000

## Dev workflow
- Create a user via sign up (Devise) or rails console:
  bin/rails c
  User.create!(email: "you@example.com", password: "password", password_confirmation: "password")
- Send messages from the Hangouts page (root). Messages are broadcast with Turbo streams.
- If broadcasts do not appear instantly, confirm:
  - The view includes: <%= turbo_stream_from "messages" %>
  - The message container has id="message-display"
  - Partial exists at app/views/messages/_message.html.erb

## Database & Migrations
- Migrations live in db/migrate. Run:
  bin/rails db:migrate

## Testing

This project uses **RSpec** for testing with the following test suite:

- **Model Tests**: Unit tests for User and Message models
- **Controller Tests**: Tests for Messages and Hangouts controllers
- **Channel Tests**: ActionCable channel tests for real-time features
- **System Tests**: End-to-end tests using Capybara

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run with code coverage report
COVERAGE=true bundle exec rspec

# Run specific test files
bundle exec rspec spec/models
bundle exec rspec spec/controllers
bundle exec rspec spec/channels
bundle exec rspec spec/system

# Run with documentation format
bundle exec rspec --format documentation
```

### Test Coverage

- **50 test cases** covering models, controllers, channels, and system integration
- **60%+ code coverage** across critical paths
- Tests run in **~1 second** for fast feedback

### Test Stack

- **rspec-rails**: Testing framework
- **factory_bot_rails**: Test data generation
- **faker**: Fake data for realistic test scenarios
- **capybara**: Browser simulation for integration tests
- **shoulda-matchers**: One-liner matchers for common Rails functionality
- **simplecov**: Code coverage reporting

## Troubleshooting
- Missing partial errors: create app/views/messages/_message.html.erb and ensure it renders one message (local `message`).
- If Action Cable needs Redis in production, configure config/cable.yml and start a Redis server.
- Tail logs: tail -f log/development.log

## Deployment

This app is production-ready with:

- **Container Support**: Dockerfile included for containerized deployments
- **Kamal**: Zero-downtime deployment support (see Gemfile)
- **Asset Optimization**: Precompilation and caching configured
- **Action Cable**: Redis adapter ready for production real-time features

### Production Considerations

1. Set `RAILS_ENV=production`
2. Configure `config/database.yml` for production database
3. Set up Redis for Action Cable (config/cable.yml)
4. Precompile assets: `bin/rails assets:precompile`
5. Configure environment variables (SECRET_KEY_BASE, etc.)

## Code Quality

This project follows Rails best practices:

- **Strong Parameters**: Protected against mass assignment
- **Model Validations**: Data integrity at the model level
- **Foreign Key Constraints**: Database-level referential integrity
- **Associations**: Proper `dependent: :destroy` for cascading deletes
- **XSS Protection`: All user output is escaped with `h()` helper
- **Authentication**: All controllers protected with `before_action :authenticate_user!`


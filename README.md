# Messenger

Simple Rails chat/demo app using Rails 8 + Hotwire (Turbo/Stimulus), Devise, and Action Cable.

## Requirements
- Ruby 3.3.5 (rbenv/rvm as preferred)
- Node not required (importmap used)
- SQLite3 for development
- Bundler (bundle)
- Optional: Redis for production Action Cable/queues

## Gems of note
- rails ~> 8.0.2
- turbo-rails, stimulus-rails
- devise (authentication)
- propshaft (assets)
- importmap-rails
- redis (optional)

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

## Tests
- No test suite included by default. Add RSpec or Minitest as needed.

## Troubleshooting
- Missing partial errors: create app/views/messages/_message.html.erb and ensure it renders one message (local `message`).
- If Action Cable needs Redis in production, configure config/cable.yml and start a Redis server.
- Tail logs: tail -f log/development.log

## Deployment
- Container-friendly; see Gemfile (kamal) for Docker-oriented deployments.
- Precompile assets for production and configure caching/adapter (Redis or database-backed).


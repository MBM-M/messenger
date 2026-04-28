# Configure Devise for testing
RSpec.configure do |config|
  # Include custom Devise controller helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  # For controller specs, set up Devise and initialize Warden
  config.before(:each, type: :controller) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    # Initialize Warden proxy if not already present
    @request.env['warden'] ||= Warden::Proxy.new(@request.env, Warden::Manager.new(@request.env))
  end
end

module Devise
  module Test
    module ControllerHelpers
      def sign_in(user, scope: :user)
        warden.set_user(user, scope: scope, store: false)
      end

      def sign_out(scope = :user)
        warden.logout(scope)
      end

      def warden
        @request.env['warden']
      end
    end
  end
end

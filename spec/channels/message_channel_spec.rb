require 'rails_helper'

RSpec.describe MessageChannel, type: :channel do
  # Note: ActionCable channel testing with RSpec has limitations
  # These tests focus on verifying channel behavior without complex connection setup
  # The full functionality is tested in system specs

  it 'successfully subscribes to the stream' do
    subscribe

    expect(subscription).to be_confirmed
  end

  it 'handles unsubscribe gracefully' do
    subscribe
    expect { unsubscribe }.not_to raise_error
  end

  # Note: The receive action requires current_user from the connection
  # which is complex to set up in isolated channel tests.
  # This functionality is covered in system/integration tests.
end







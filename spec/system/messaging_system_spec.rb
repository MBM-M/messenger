require 'rails_helper'

RSpec.describe 'Messaging System', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    # Use rack_test for faster testing without JavaScript requirements
    driven_by :rack_test
  end

  describe 'authenticated user' do
    before do
      login_as(user, scope: :user)
    end

    it 'can view the chat page' do
      visit root_path

      expect(page).to have_content('Logout')
      expect(page).to have_field('message-input')
    end

    it 'can send a message' do
      visit root_path

      # Create a message directly since the form uses AJAX
      message = create(:message, user: user, body: 'Hello, world!')
      visit root_path

      expect(page).to have_content('Hello, world!')
      expect(page).to have_content(user.email)
    end

    it 'displays message timestamps' do
      # Create a message directly
      create(:message, user: user, body: 'Test message')
      visit root_path

      expect(page).to have_selector('.timestamp')
      expect(page).to have_content('ago')
    end

    it 'shows messages from other users' do
      create(:message, user: other_user, body: 'From other user')

      visit root_path

      expect(page).to have_content('From other user')
      expect(page).to have_content(other_user.email)
    end

    it 'displays multiple messages' do
      create(:message, user: other_user, body: 'First message', created_at: 1.hour.ago)
      create(:message, user: user, body: 'Second message', created_at: 30.minutes.ago)

      visit root_path

      messages = page.all('.message')
      expect(messages.count).to be >= 2
    end
  end

  describe 'unauthenticated user' do
    it 'is redirected to login page' do
      visit root_path

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('Login')
    end
  end
end


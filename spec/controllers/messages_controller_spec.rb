require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:message_attributes) { { body: 'Hello, world!' } }

  describe 'POST #create' do
    context 'with valid parameters' do
      before { sign_in user }
      it 'creates a new message' do
        expect {
          post :create, params: { message: message_attributes }
        }.to change(Message, :count).by(1)
      end

      it 'associates the message with the current user' do
        post :create, params: { message: message_attributes }

        expect(Message.last.user).to eq(user)
      end

      it 'broadcasts the message via ActionCable' do
        # Verify that ActionCable receives broadcast calls
        expect(ActionCable.server).to receive(:broadcast).at_least(:once).and_call_original

        post :create, params: { message: message_attributes }
      end

      it 'returns a successful response' do
        post :create, params: { message: message_attributes }, as: :turbo_stream

        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      before { sign_in user }
      it 'does not create a message with empty body' do
        expect {
          post :create, params: { message: { body: '' } }
        }.not_to change(Message, :count)
      end

      it 'does not create a message with nil body' do
        expect {
          post :create, params: { message: { body: nil } }
        }.not_to change(Message, :count)
      end

      it 'does not create a message with body exceeding max length' do
        expect {
          post :create, params: { message: { body: 'a' * 1001 } }
        }.not_to change(Message, :count)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        post :create, params: { message: message_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not create a message' do
        expect {
          post :create, params: { message: message_attributes }
        }.not_to change(Message, :count)
      end
    end
  end

  describe 'parameter filtering' do
    before { sign_in user }

    it 'only allows the body parameter' do
      expect {
        post :create, params: { message: { body: 'Hello', user_id: 999, admin: true } }
      }.not_to raise_error

      created_message = Message.last
      expect(created_message.user_id).to eq(user.id)
      expect(created_message).not_to respond_to(:admin)
    end
  end
end

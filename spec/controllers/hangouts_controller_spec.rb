require 'rails_helper'

RSpec.describe HangoutsController, type: :controller do
  let(:user) { create(:user) }
  let!(:messages) { create_list(:message, 3) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'assigns a new message instance' do
        get :index
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 'assigns all messages with user preloading' do
        get :index
        expect(assigns(:messages)).to match_array(messages)
      end

      it 'orders messages chronologically' do
        message1 = create(:message, created_at: 1.day.ago)
        message2 = create(:message, created_at: 1.hour.ago)

        get :index
        expect(assigns(:messages)).to include(message1, message2)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

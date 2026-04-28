require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build(:message) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }

    it { should validate_length_of(:body).is_at_most(1000) }

    context 'when body is empty' do
      subject { build(:message, body: '') }
      it { is_expected.not_to be_valid }
    end

    context 'when body exceeds maximum length' do
      subject { build(:message, :long_body) }
      it { is_expected.not_to be_valid }
    end

    context 'when body is nil' do
      subject { build(:message, body: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe 'callbacks' do
    describe '#broadcast_message' do
      let(:user) { create(:user) }
      let(:message) { build(:message, user: user, body: 'Test message') }

      it 'broadcasts the message after creation' do
        expect(message).to receive(:broadcast_append_to).with('messages', target: 'message-display')
        message.save!
      end

      it 'broadcasts only after create commit' do
        expect(message).to receive(:broadcast_append_to).with('messages', target: 'message-display')
        message.save
      end
    end
  end

  describe 'scopes and queries' do
    let(:user) { create(:user) }
    let!(:old_message) { create(:message, user: user, created_at: 2.days.ago) }
    let!(:new_message) { create(:message, user: user, created_at: 1.hour.ago) }

    it 'orders messages by creation time' do
      expect(Message.all).to eq([old_message, new_message])
    end

    it 'includes user association when accessed' do
      message = create(:message)
      expect(message.user).to be_a(User)
      expect(message.user.email).to be_present
    end
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(create(:message)).to be_valid
    end

    it 'creates a message with a user' do
      message = create(:message)
      expect(message.user).to be_persisted
    end
  end
end

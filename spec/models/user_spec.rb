require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe 'Devise modules' do
    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end
  end

  describe 'validations' do
    context 'when email is missing' do
      subject { build(:user, email: nil) }
      it { is_expected.not_to be_valid }
    end

    context 'when password is missing' do
      subject { build(:user, password: nil) }
      it { is_expected.not_to be_valid }
    end

    context 'when email is not unique' do
      let(:existing_user) { create(:user, email: 'test@example.com') }
      subject { build(:user, email: existing_user.email) }

      it { is_expected.not_to be_valid }
    end

    context 'with valid attributes' do
      it { is_expected.to be_valid }
    end
  end

  describe 'messages association' do
    let(:user) { create(:user) }

    it 'can have messages' do
      message1 = create(:message, user: user)
      message2 = create(:message, user: user)

      expect(user.messages).to include(message1, message2)
    end

    it 'destroys dependent messages' do
      message = create(:message, user: user)
      user.destroy

      expect(Message.find_by(id: message.id)).to be_nil
    end
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(create(:user)).to be_valid
    end

    it 'generates unique emails' do
      user1 = create(:user)
      user2 = create(:user)

      expect(user1.email).not_to eq(user2.email)
    end
  end

  describe '.with_messages trait' do
    it 'creates user with messages' do
      user = create(:user, :with_messages)

      expect(user.messages.count).to eq(3)
    end
  end
end

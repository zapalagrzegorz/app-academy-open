# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # validations
  # it { should validate_presence_of(:email) }
  #
  # You should validate:
  #
  # Presence of email
  # Presence of password_digest
  # Length of password > 6

  subject(:user) do
    FactoryBot.build(:user,
                     email: 'jonathan@fakesite.com',
                     password: 'good_password')
  end

  let(:user2) do
    FactoryBot.build(:user,
                     email: 'zapala.grzegorz@gmail.com',
                     password: '123456')
  end

  let(:user3) { User.create(email: 'zapala.grzegorz@gmail.com', password: '123457') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest).with_message('Password cannot be empty') }

    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:password_digest) }
    it { should validate_uniqueness_of(:session_token) }
  end

  # it "creates a password digest when a password is given" do
  #   expect(user.password_digest).to_not be_nil
  # end

  # it "creates a session token before validation" do
  #   user.valid?
  #   expect(user.session_token).to_not be_nil
  # end

  describe 'associations' do
    it { should have_many(:notes) }
  end

  # and ::find_by_credentials.

  describe 'instance methods' do
    describe '#is_password?' do
      context 'when given correct password' do
        it 'should return true' do
          expect(user3.is_password('123457')).to be true
        end
      end
      context 'when given incorrect password' do
        it 'should return false' do
          expect(user3.is_password('123455')).to be false
        end
      end
    end

    describe '#reset_session_token' do
      it 'generates new session token' do
        # old session_token != new session token
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq old_token
      end

      # it "returns the new session token" do
      #   expect(user.reset_session_token!).to eq(user.session_token)
      # end
    end
  end

  describe 'class methods' do
    describe '::find_user_by_credentials' do
      # czemu create! nie działa?
      before { user3.save! }

      context 'when given correct login and password' do
        # let(:user3) { User.create!(email: 'zapala.grzegorz@gmail.com', password: '123457') }
        it 'returns user' do
          expect(User.find_user_by_credentials('zapala.grzegorz@gmail.com', '123457')).not_to be nil
          expect(User.find_user_by_credentials('zapala.grzegorz@gmail.com', '123457')).to eq(user3)
        end
      end
      context 'when given incorrect login or password' do
        it 'returns nil' do
          expect(User.find_user_by_credentials('zapala.grz.com', '123457')).to eq nil
          expect(User.find_user_by_credentials('zapala.grzegorz@gmail.com', '1234579872')).to eq nil
        end
      end
    end
  end
end

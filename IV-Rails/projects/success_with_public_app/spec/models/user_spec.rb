# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  session_token    :string           not null
#  password_digest  :string           not null
#  activated        :boolean          default(FALSE), not null
#  boolean          :boolean          default(FALSE), not null
#  activation_token :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # validations

  subject(:user) { User.new(email: 'zapala.grzegorz@gmail.com', password: '123456') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest).with_message('Password cannot be empty') }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:password_digest) }
    # it { should validate_length_of(:password).is_at_least(6) }
  end

  # associations
  # has many goals
  # has many

  # methods
  # is_password?
  # generate_session_token
  # User.find_by_credential(email, password)
  # reset_session_token
  describe 'instance methods' do
    describe '#ensure_session_token' do
      it 'sets a session token before validation' do
        user.valid?
        expect(subject.session_token).not_to be_nil
      end
    end

    describe '#ensure_activation_token' do
      it 'sets a activation token before validation' do
        user.valid?
        expect(subject.activation_token).not_to be_nil
      end
    end

    describe '#is_password?' do
      context 'when given correct password' do
        it 'should return true' do
          expect(user.is_password?('123456')).to be true
        end
      end
      context 'when given incorrect password' do
        it 'should return false' do
          expect(user.is_password?('123455')).to be false
        end
      end
    end

    describe '#reset_session_token' do
      it 'sets new session token on user' do
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq old_token
      end

      it 'returns the new session token' do
        expect(user.reset_session_token!).to eq(user.session_token)
      end
    end
  end

  describe 'class methods' do
    describe '::find_user_by_credentials' do
      # czemu create! nie działa?
      before { subject.save! }

      context 'when given correct login and password' do
        it 'returns user' do
          expect(User.find_user_by_credentials('zapala.grzegorz@gmail.com', '123456')).not_to be nil
          expect(User.find_user_by_credentials('zapala.grzegorz@gmail.com', '123456')).to eq(subject)
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

# frozen_string_literal: true

class User < ApplicationRecord
  attr_reader :password
  validates :username, :session_token, presence: false
  validates :username, :password_digest, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }

  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    return nil unless user.password_digest.is_password?(password)

    user
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  # This method resets the user's session_token and saves the user
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    save
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  def ensure_session_token
    reset_session_token! unless session_token
  end
end

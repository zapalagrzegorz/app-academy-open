# frozen_string_literal: true

class User < ApplicationRecord
  attr_reader :password

  validates :session_token, :username, presence: true

  validates :password_digest, :session_token, uniqueness: true

  validates :password_digest, presence: { message: 'Password cannot be empty' }

  validates :password, length: { minimum: 6, unique: true }

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user

    user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    password_digest.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    session_token = self.class.generate_session_token
    save!

    session_token
  end

  private

  def ensure_session_token
    # reset_session_token! unless session_token
    self.session_token ||= self.class.generate_session_token
  end
end

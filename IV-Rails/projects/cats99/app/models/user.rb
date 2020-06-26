# frozen_string_literal: true

require 'bcrypt'

class User < ApplicationRecord
  # !
  validates :username, presence: true, uniqueness: true

  validates :session_token, :username, presence: true

  validates :password_digest, :session_token, uniqueness: true

  validates :password_digest, presence: { message: 'Password cannot be empty' }

  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :cats, dependent: :destroy

  has_many :cat_rental_requests, dependent: :destroy

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user

    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  # def owns_cat?(cat)
  #   cat.user_id == self.id
  # end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    save!

    session_token
  end

  private

  def ensure_session_token
    # reset_session_token! unless session_token
    self.session_token ||= self.class.generate_session_token
  end
end

# frozen_string_literal: true

require 'bcrypt'
class User < ApplicationRecord
  attr_reader :password

  validates :email, :session_token, presence: true

  validates :password, length: { minimum: 6, maximum: 20, allow_nil: true }

  validates :email, :password_digest, :session_token, uniqueness: true
  # :session_token tez unique

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :password_digest, presence: { message: 'Password cannot be empty' }

  after_initialize :ensure_session_token, :ensure_activation_token

  has_many :notes, dependent: :destroy

  # finds user in db by email and password
  def self.find_user_by_credentials(email, password)
    # debugger
    user = User.find_by(email: email)
    return if user.nil?

    user.is_password(password) ? user : nil
  end

  # password setter
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  # checks given text-password against hashed-salted password in db
  # should be is_password?
  def is_password(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    save!

    session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= generate_session_token
  end
end

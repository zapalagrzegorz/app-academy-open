# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string           not null
#  password_hash :string           not null
#  session_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'bcrypt'

class User < ApplicationRecord
  attr_reader :password

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_hash, presence: { message: 'Password cannot be blank' }
  validates :password, length: { minimum: 6, maximum: 20, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :subs, class_name: 'Sub', foreign_key: 'moderator_id'

  has_many :posts, class_name: 'Post', foreign_key: 'author_id'

  has_many :comments, class_name: "Comment", foreign_key: 'author_id'


  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  # kind of password_getter
  def is_password?(password)
    # take my password_hash, unhash it, and check does it match
    BCrypt::Password.new(password_hash).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    # not persisted!!!!
    # need to save change of state
    save!
    session_token
    # session[:session_token] = nil
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_user_by_credentials(email, password)
    user = User.find_by(email: email)

    return if user.nil?

    user.is_password?(password) ? user : nil
  end
end

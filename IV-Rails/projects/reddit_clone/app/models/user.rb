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

  after_initialize :ensure_session_token

  validates :email, :session_token, presence: true, uniqueness: true

  validates :password_hash, presence: { message: 'Password cannot be blank' }
  validates :password, length: { minimum: 6, maximum: 20, allow_nil: true }

  has_many :subs, class_name: 'Sub', foreign_key: 'moderator_id', inverse_of: :moderator

  has_many :posts, class_name: 'Post', foreign_key: 'author_id', inverse_of: :author

  has_many :comments, class_name: 'Comment', foreign_key: 'author_id', inverse_of: :author

  #   has_many :user_votes, inverse_of: :user

  def self.find_user_by_credentials(email, password)
    user = User.find_by(email: email)

    return if user.nil?

    user.is_password?(password) ? user : nil
  end

  # gdyby to była klasa statyczna
  # wywołanie jej w ramach obiektu to:
  # self.class.generate_session_token
  def generate_session_token
    SecureRandom.urlsafe_base64
    # zapobiegaj duplikatom
    # begin
    #   token = SecureRandom.urlsafe_base64(16)
    # end while User.exists?(session_token: token)
    # token
  end

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

  # private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # being followed
  has_many :in_follows,
           foreign_key: :followee_id,
           class_name: :Follow

  # follows others
  has_many :out_follows,
           foreign_key: :follower_id,
           class_name: :Follow

  has_many :followers,
           through: :in_follows,
           source: :follower

  has_many :followees,
           through: :out_follows,
           source: :followee

  has_many :tweets, dependent: :destroy

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    # no user with given username
    return nil if user.nil?

    # check user's password
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
  end

  def feed_tweets(limit = nil, max_created_at = nil)
    # Time.now.midnight
    # LEFT OUTER JOIN
    # zwróć wszyskie z lewej tabeli, łączne elementy i z prawej null, jeśli nie ma matched record
    # po co tabela follows?
    # daj followsy, tam gdzie uzytkownicy są śledzeni (wszystkich śledzonych)
    # .where('tweets.user_id = :id OR follows.follower_id = :id', id: id)
    # i do tego tam gdzie śledzącykm jest nasz użytkownik!
    # daj mi moje tweety oraz tweety śledzonych użytkowników!
    # follows.follower_id - tj uzytkownik który sledzi
    #
    @tweets = Tweet
              .joins(:user)
              .joins('LEFT OUTER JOIN follows ON users.id = follows.followee_id')
              .where('tweets.user_id = :id OR follows.follower_id = :id', id: id)
              .order('tweets.created_at DESC')
              .distinct
    # .where('tweets.created_at < :max_created_at', max_created_at: max_created_at)
    # .limit(':limit', limit: limit)

    # TODO: How can we use limit/max_created_at here??
    @tweets = @tweets.limit(limit) if limit
    @tweets = @tweets.where('tweets.created_at < ?', max_created_at) if max_created_at

    @tweets
  end

  def followed_user_ids
    @followed_user_ids ||= out_follows.pluck(:followee_id)
  end

  def follows?(user)
    followed_user_ids.include?(user.id)
  end
end

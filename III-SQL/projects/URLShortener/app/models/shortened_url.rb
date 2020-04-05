# frozen_string_literal: true

# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_shortened_urls_on_short_url  (short_url) UNIQUE
#  index_shortened_urls_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'securerandom'
require_relative 'user'
require_relative 'visit'

class ShortenedUrl < ApplicationRecord
  #  validates :long_url, :short_url, :submitter, presence: true
  validates :long_url, :short_url, presence: true
  validates :short_url, uniqueness: { case_sensitive: false }

  belongs_to :submitter,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: :User

  has_many :visitors,
           #  -> { distinct }, # <<<
           through: :visits,
           source: :visitor

  # SecureRandom.urlsafe_base64
  # ShortenedUrl::random_code
  def self.random_code
    # nil
    url_safe_string = SecureRandom.urlsafe_base64
    while exists? short_url: url_safe_string
      url_safe_string = SecureRandom.urlsafe_base64
    end

    url_safe_string
  end

  # def self.random_code
  #   loop do
  #     random_code = SecureRandom.urlsafe_base64(16)
  #     return random_code unless ShortenedUrl.exists?(short_url: random_code)
  #   end
  # end

  def self.generate_shortened_url(first_user = random_code, long_url: random_code)
    user = first_user ?
             User.first
           :
             User.create(email: random_code)

    ShortenedUrl.create(long_url: random_code, short_url: random_code, user_id: user.id)
  end

  # num_clicks should count the number of clicks on a ShortenedUrl.
  def num_clicks
    Visit.where('shortened_url_id = ?', id).count
  end

  # num_uniques
  # should determine the number of distinct users who have clicked a link.

  def num_uniques
    Visit.select(:user_id).distinct.count
  end

  # num_recent_uniques
  def num_recent_uniques
    Visit.select(:user_id).distinct.where('created_at > ?', 10.minutes.ago).count
  end
  # Write a factory method that takes a User object and a long_url string and create!s a new ShortenedUrl.

  # Write submitter and submitted_urls associations to ShortenedUrl and User.
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  submitter_id :integer          not null
#
# Indexes
#
#  index_shortened_urls_on_short_url     (short_url) UNIQUE
#  index_shortened_urls_on_submitter_id  (submitter_id)
#
require 'securerandom'
require_relative 'user'
require_relative 'visit'

class ShortenedUrl < ApplicationRecord
  #  validates :long_url, :short_url, :submitter, presence: true
  validates :long_url, :short_url, :submitter, presence: true
  validates :short_url, uniqueness: { case_sensitive: false }
  validate :no_spamming, :non_premium_max

  belongs_to :submitter,
             primary_key: :id,
             foreign_key: :submitter_id,
             class_name: 'User'

  has_many :visitors,
           -> { distinct },
           through: :visits,
           source: :visitor

  has_many :visits,
           primary_key: :id,
           foreign_key: :shortened_url_id,
           class_name: 'Visit'
  # has_many optional tag_topics

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

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  # num_clicks should count the number of clicks on a ShortenedUrl.
  def num_clicks
    Visit.where('shortened_url_id = ?', id).count
  end

  # should determine the number of distinct users who have clicked a link.
  def num_uniques
    Visit.select(:user_id).distinct.count
  end

  def num_recent_uniques
    Visit.select(:user_id).distinct.where('created_at > ?', 10.minutes.ago).count
  end

  # First, write a custom validation method ShortenedUrl#no_spamming.
  # Remember to provide an informative error message if the validation fails.
  # Prevent users from submitting more than 5 URLs in a single minute.
  def no_spamming
    num_added_urls = ShortenedUrl.where('submitter_id = :submitter_id AND created_at > :created_at', submitter_id: submitter.id, created_at: 5.minutes.ago).count

    if num_added_urls > 1 && !submitter.premium
      errors[:maximum] << 'No more urls than 1 per 5 minutes for non-premiums'
      puts ''
    end

    # Now add a custom validation method ShortenedUrl#nonpremium_max. To do this you'll first have to add a "premium" boolean column to your Users table. This column should default to false unless a boolean is given.
  end

  def non_premium_max
    if submitter.submitted_urls.count >= 5 && !submitter.premium
      errors[:premium] << 'users are only allowed to submit more than 5 urls'
    end
  end
end

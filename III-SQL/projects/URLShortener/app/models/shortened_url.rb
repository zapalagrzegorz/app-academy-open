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
           class_name: 'Visit',
           dependent: :destroy
  # has_many optional tag_topics
  has_many :taggings,
           primary_key: :id,
           foreign_key: :shortened_url_id,
           class_name: 'Tagging',
           dependent: :destroy

  has_many :tag_topics,
           through: :taggings,
           source: :tag_topic
  # SecureRandom.urlsafe_base64
  # ShortenedUrl::random_code
  def self.random_code
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

  # Prevent users from submitting more than 5 URLs in a single minute.
  def no_spamming
    num_added_urls = ShortenedUrl.where('submitter_id = :submitter_id AND created_at > :created_at', submitter_id: submitter.id, created_at: 5.minutes.ago).count

    if num_added_urls > 3 && !submitter.premium
      errors[:maximum] << 'No more urls than 3 per 5 minutes for non-premiums'
      puts ''
    end
  end

  def non_premium_max
    if submitter.submitted_urls.count >= 5 && !submitter.premium
      errors[:premium] << 'users are only allowed to submit more than 5 urls'
    end
  end

  # self.left_outer_joins(:visits)
  #           .join(:users)
  #
  def self.prune(n)
    # .joins("LEFT JOIN visits ON visits.sshortened_url_id = shortened_urls.id")
    ShortenedUrl.joins(:submitter)
                .left_outer_joins(:visits)
                .where("(shortened_urls.created_at < \'#{n.minute.ago}\' AND visits.created_at IS NULL)
          OR shortened_urls.created_at < \'#{n.minute.ago}\'
          AND users.premium = \'f\'").destroy_all
    # .where("(shortened_urls.id IN (
    #   SELECT shortened_urls.id
    #   FROM shortened_urls
    #   JOIN visits
    #   ON visits.shortened_url_id = shortened_urls.id
    #   GROUP BY shortened_urls.id
    #   HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
    # ) OR (
    #   visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
    # )) AND users.premium = \'f\'")
  end
end

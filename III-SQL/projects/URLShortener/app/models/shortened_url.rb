# frozen_string_literal: true

require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: { case_sensitive: false }
  validates :short_url, presence: true, uniqueness: { case_sensitive: false }

  # SecureRandom.urlsafe_base64
  # ShortenedUrl::random_code
  def self.random_code
    nil
  end
end

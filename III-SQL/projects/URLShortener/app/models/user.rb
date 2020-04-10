# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  premium    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  attr_accessor :premium

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :visits,
           primary_key: :id,
           foreign_key: :user_id,
           class_name: 'Visit'

  has_many :visited_urls,
           -> { distinct },
           through: :visits,
           source: :visited_url

  has_many :submitted_urls,
           primary_key: :id,
           foreign_key: :submitter_id,
           class_name: 'ShortenedUrl'
end

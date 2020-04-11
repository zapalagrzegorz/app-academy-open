# frozen_string_literal: true

# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tag_topics_on_title  (title) UNIQUE
#
require_relative 'visit'

class TagTopic < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many :taggings,
           primary_key: :id,
           foreign_key: :tag_topic_id,
           class_name: 'Tagging',
           dependent: :destroy

  #             dependent: :destroy
  has_many :shortened_urls,
           through: :taggings,
           source: :shortened_url

  #   Now write a method TagTopic#popular_links that returns the 5 most visited links for that TagTopic along with the number of times each link has been clicked.

  # Don't worry about updating your CLI so users can add a TagTopic to a new URL. Just make sure that you can create working TagTopic objects and view the most popular links for a tag in the console.
  def popular_links
    # SELECT long_url, COUNT(*) AS number_of_visits
    # FROM visits JOIN shortened_urls
    # ON visits.shortened_url_id = shortened_urls.id
    # GROUP BY long_url, short_url
    # WHERE TagTopic = ?
    # limit 5
    # SORT BY DESCs

    shortened_urls.joins(:visits)
                  .group(:short_url, :long_url)
                  .order('COUNT(visits.id) DESC')
                  .limit(5)
                  .count
    # .select('COUNT(*) as count_all, long_url, short_url')
  end
end

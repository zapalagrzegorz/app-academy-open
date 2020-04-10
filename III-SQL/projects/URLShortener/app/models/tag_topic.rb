# frozen_string_literal: true

require_relative 'visit'

class TagTopic < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many :taggings,
           primary_key: :id,
           foreign_key: :tag_topic_id,
           class_name: 'Tagging'
  #  czyli?
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
    # SORT BY DESC

    shortened_urls.joins(:visits)
                  .group(:short_url, :long_url)
                  .order('COUNT(visits.id) DESC')
                  .limit(5)
                  .count
    # .select('COUNT(*) as count_all, long_url, short_url')
  end
end

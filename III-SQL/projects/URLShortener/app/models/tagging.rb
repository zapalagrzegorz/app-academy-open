# frozen_string_literal: true

# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :bigint           not null
#  tag_topic_id     :bigint           not null
#
# Indexes
#
#  index_taggings_on_shortened_url_id                   (shortened_url_id)
#  index_taggings_on_tag_topic_id_and_shortened_url_id  (tag_topic_id,shortened_url_id) UNIQUE
#
class Tagging < ApplicationRecord
  # obecność powiązanego obiektu a nie klucza
  validates :shortened_url, :tag_topic, presence: true

  # pochodna unikalności do bazy ze względu na dwa pola/kolumny
  validates :tag_topic_id, uniqueness: { scope: :shortened_url_id }
  # uniqueness

  belongs_to :shortened_url,
             primary_key: :id,
             foreign_key: :shortened_url_id,
             class_name: 'ShortenedUrl'

  belongs_to :tag_topic,
             primary_key: :id,
             foreign_key: :tag_topic_id,
             class_name: 'TagTopic'
end

# frozen_string_literal: true

class Tagging < ApplicationRecord
  # obecność powiązanego obiektu a nie klucza
  validates :shortened_url, :tag_topic, presence: true

  # pochodna unikalności do bazy ze względu na dwa pola/kolumny
  validates :tag_topic_id, uniqueness: { scope: :shortened_url_id }
  # uniqueness

  belongs_to :shortened_url,
             primary_key: :id,
             foreign_key: :shortened_url_id,
             class_name: 'Shortened_url'

  belongs_to :tag_topic,
             primary_key: :id,
             foreign_key: :tag_topic_id,
             class_name: 'TagTopic'
end

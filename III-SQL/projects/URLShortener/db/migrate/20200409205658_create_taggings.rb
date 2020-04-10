# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.bigint :tag_topic_id, null: false
      t.bigint :shortened_url_id, null: false

      t.timestamps
    end
    add_index :taggings, %i[tag_topic_id shortened_url_id], unique: true
    # szukanie tylko po kluczu obcym, a nie tylko eliminacja duplikatów
    add_index :taggings, :shortened_url_id

    # zbędne? - nie wykonalne, bo jeszcze tabeli nie ma
    # add_foreign_key :shortened_urls, :taggings, column: :shortened_url_id
    # add_foreign_key :tag_topics, :taggings, column: :tag_topic_id
  end
end

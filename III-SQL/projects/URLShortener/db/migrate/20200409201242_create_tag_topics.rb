# frozen_string_literal: true

class CreateTagTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_index :tag_topics, :title, unique: true
  end
end

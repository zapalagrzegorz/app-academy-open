# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.belongs_to :sub, index: true, foreign_key: true
      t.bigint :author_id
      t.timestamps
    end

    add_index :posts, :author_id
  end
end

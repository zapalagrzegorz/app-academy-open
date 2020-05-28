# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :user_id
      # t.bigint  :imageable_id
      # t.string  :imageable_type
      t.references :likeable, polymorphic: true, index: true
      t.timestamps
    end

    add_index :likes, %i[user_id likeable_type likeable_id], unique: true
  end
end

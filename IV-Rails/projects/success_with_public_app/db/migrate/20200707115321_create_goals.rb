# frozen_string_literal: true

class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      # po co?
      t.index :title
      t.text :details
      t.boolean :completed, default: false
      t.boolean :private, default: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end

# t.string :title, null: false
# t.boolean :private, null: false, default: false
# t.text :details
# t.boolean :completed, null: false, default: false
# t.integer :user_id, null: false

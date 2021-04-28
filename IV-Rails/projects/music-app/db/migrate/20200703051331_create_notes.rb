# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.belongs_to :user
      t.belongs_to :track
      t.text :content, null: false
      t.timestamps
    end
  end
end

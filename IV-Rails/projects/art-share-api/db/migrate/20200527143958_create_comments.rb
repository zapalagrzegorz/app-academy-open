# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :artwork, foreign_key: true, null: false
      t.belongs_to :user, foreign_key: true, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end

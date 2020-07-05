# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.belongs_to :band, index: true, foreign_key: true

      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :studio, default: true

      t.timestamps
    end
  end
end

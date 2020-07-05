# frozen_string_literal: true

class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.belongs_to :album, index: true, foreign_key: true
      t.string :title, null: false
      t.integer :ord, null: false
      t.boolean :regular, null: false

      t.text :lyrics
      t.timestamps
    end

    # could've added default value for :regular
  end
end

# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      # belongs_to wygeneruje kolumnę klucza obcego - todo_id
      t.belongs_to :todo, index: true, foreign_key: true
      t.string :title, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.timestamps
    end

    # could have added index, with unique!
  end
end

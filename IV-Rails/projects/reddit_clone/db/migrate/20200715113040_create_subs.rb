# frozen_string_literal: true

class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      # Sub should have title and description attributes and a moderator association.
      # The creator of the Sub is the moderator.
      t.string :title, null: false
      # no two subs of the same title should be possible
      # t.index :title, unique: true
      
      t.text :description, null: true

      t.bigint :moderator_id, null: false
      t.timestamps
    end

    # gdyby dać unique to dany moderator mógłby być tylko raz
    # czyli tylko raz dany użytkownik mógłby zostać moderatorem
    add_index :subs, :moderator_id, unique: false
  end
end

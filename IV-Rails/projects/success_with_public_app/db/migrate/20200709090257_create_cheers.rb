# frozen_string_literal: true

class CreateCheers < ActiveRecord::Migration[5.2]
  def change
    create_table :cheers do |t|
      t.bigint :giver_id, null: false
      t.belongs_to :goal, index: true, foreign_key: true
      t.timestamps
    end

    add_index :cheers, :giver_id

    # unikalność!
    # dany goal użytkownik moze polubic tylko raz
    ##
    # This second index allows us to search for
    # both `goal_id` and `[:goal_id, :giver_id]`!!
    # (but not giver_id alone, order matters!)
    ##
    add_index :cheers, %i[goal_id giver_id], unique: true
  end
end

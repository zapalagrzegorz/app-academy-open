# frozen_string_literal: true

class AddUniqueNameDateCatConstraint < ActiveRecord::Migration[5.2]
  def change
    add_index :cats, %i[name birth_date], unique: true
  end
end

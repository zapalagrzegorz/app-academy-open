# frozen_string_literal: true

class AddUserToCatRentalRequest < ActiveRecord::Migration[5.2]
  def change
    change_table :cat_rental_requests do |t|
      t.belongs_to :user, foreign_key: true, null: false
    end
  end
end

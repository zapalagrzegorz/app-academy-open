# frozen_string_literal: true

class CreateCatRentalRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :cat_rental_requests do |t|
      t.belongs_to :cat, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false, default: 'PENDING'
    end
  end
end

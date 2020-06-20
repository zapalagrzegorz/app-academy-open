# frozen_string_literal: true

class AddUserToCats < ActiveRecord::Migration[5.2]
  def change
    change_table :cats do |t|
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end

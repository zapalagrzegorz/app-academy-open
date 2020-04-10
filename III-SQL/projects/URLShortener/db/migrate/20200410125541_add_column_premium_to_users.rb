# frozen_string_literal: true

class AddColumnPremiumToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :premium, :boolean, default: false
  end
end

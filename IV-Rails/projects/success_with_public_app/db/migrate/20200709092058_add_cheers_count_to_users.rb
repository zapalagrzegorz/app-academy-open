# frozen_string_literal: true

class AddCheersCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cheer_count, :integer, null: false
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

# frozen_string_literal: true

class AddUserActivation < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, default: false, null: false
    add_column :users, :activation_token, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

# frozen_string_literal: true

class AddIndexUsernameAndRemoveIndexPasswordDigest < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :username, unique: true
    remove_index :users, :password_digest
  end
end

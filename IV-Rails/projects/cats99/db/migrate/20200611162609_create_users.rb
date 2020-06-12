# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.index :password_digest, unique: true
      t.string :session_token
      t.index :session_token, unique: true

      t.timestamps
    end
  end
end

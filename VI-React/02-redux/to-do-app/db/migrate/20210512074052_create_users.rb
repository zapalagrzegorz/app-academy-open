# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.index :email, unique: true

      # w bazie nie ma hasła, a tylko jego zahashowaną postać
      t.string :password_hash, null: false

      # ustaw sesję cookies do autoryzacji
      t.string :session_token, null: false
      t.index :session_token, unique: true
      t.timestamps
    end
  end
end

# frozen_string_literal: true

# email
# password_hash
# session_token
#
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_hash, null: false
      # nie szukasz po password_hashu, ale po emailu
      # !to czemu nie dałem wcześniej indeksu dla email'a?
      # t.index :email, unique: true

      # dopiero jak znajdziesz usera, to pytasz czy password = odkodowany_password_hash =
      # t.index :password_hash, unique: true

      t.string :session_token, null: false
      t.index :session_token, unique: true
      t.timestamps
    end
  end
end

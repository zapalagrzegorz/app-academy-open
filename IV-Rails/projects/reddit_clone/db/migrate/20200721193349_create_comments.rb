# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.bigint :author_id
      t.belongs_to :post, index: true, foreign_key: true

      t.timestamps
    end

    add_index :comments, :author_id
  end
end

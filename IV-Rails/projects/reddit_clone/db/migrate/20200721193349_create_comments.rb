# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content # null: false
      t.bigint :author_id # null: false by nie zaszkodził
      # belongs_to przyjmuje również opcję null, domyślnie false
      t.belongs_to :post, index: true, foreign_key: true

      t.timestamps
    end

    add_index :comments, :author_id
  end
end

# frozen_string_literal: true

class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.belongs_to :sub, index: true, foreign_key: true
      t.belongs_to :post, index: true, foreign_key: true

      t.timestamps
    end

    add_index :post_subs, %i[sub_id post_id], unique: true
    # Ex:- add_index("admin_users", "username")
  end
end

# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.belongs_to :user
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end

    # add_index :table_name, :[], options: "custom_index_name"
    # Ex:- add_index("admin_users", "username")

    drop_table :user_comments
    drop_table :goal_comments
  end
end

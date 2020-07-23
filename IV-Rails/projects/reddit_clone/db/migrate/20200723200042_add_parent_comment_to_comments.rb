# frozen_string_literal: true

class AddParentCommentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment_id, :bigint
  end

  add_index :comments, :parent_comment_id
end

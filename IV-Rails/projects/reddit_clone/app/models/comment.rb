# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :post

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :child_comments, class_name: 'Comment', foreign_key: 'parent_comment_id'

  belongs_to :parent_comment, class_name: "Comment", optional: true
end

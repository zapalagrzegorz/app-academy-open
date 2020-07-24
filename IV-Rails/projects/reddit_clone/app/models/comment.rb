# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text
#  author_id         :bigint
#  post_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :bigint
#
class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :post

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :child_comments, class_name: 'Comment', foreign_key: 'parent_comment_id'

  # optional: true - as is nil for top level comments
  belongs_to :parent_comment, class_name: 'Comment', optional: true
end

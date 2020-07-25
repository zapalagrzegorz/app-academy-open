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
  # komentarze i posty są Votable
  # include Votable

  # after_initialize :ensure_post_id!

  validates :content, presence: true

  has_many :child_comments,
           class_name: 'Comment',
           foreign_key: 'parent_comment_id'

  belongs_to :post

  belongs_to :author,
             class_name: 'User',
             foreign_key: 'author_id',
             inverse_of: :comments

  # optional: true - as is nil for top level comments
  belongs_to :parent_comment,
             class_name: 'Comment',
             optional: true

  # private
  # def ensure_post_id!
  #   self.post_id ||= self.parent_comment.post_id if parent_comment
  # end
end

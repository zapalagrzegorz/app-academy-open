# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  content          :text             not null
#  user_id          :bigint
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :commentable, polymorphic: true
end

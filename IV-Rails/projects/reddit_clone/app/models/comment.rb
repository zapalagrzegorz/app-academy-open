# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :post

  belongs_to :author, class_name: "User", foreign_key: "author_id"
end

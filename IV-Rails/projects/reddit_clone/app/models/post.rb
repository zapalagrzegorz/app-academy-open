# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  # belongs_to :sub, class_name: 'Sub'

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub

  # post#subs_ids =
end

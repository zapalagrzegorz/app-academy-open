# frozen_string_literal: true

class Sub < ApplicationRecord
  # Sub should have title and description attributes and a moderator association. The creator of the Sub is the moderator.
  # t.string :title, null: false
  # t.text :description, null: true

  # t.bigint :moderator_id, null: false
  validates :title, :description, presence: true

  belongs_to :moderator, class_name: 'User', foreign_key: 'moderator_id'

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :posts, through: :post_subs, source: :post
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Sub < ApplicationRecord
  # Sub should have title and description attributes and a moderator association. The creator of the Sub is the moderator.
  # t.string :title, null: false
  # t.text :description, null: true

  # t.bigint :moderator_id, null: false
  validates :title, :description, presence: true
  #   validates :name, uniqueness: true

  belongs_to :moderator, class_name: 'User', foreign_key: 'moderator_id', inverse_of: :subs

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :posts, through: :post_subs, source: :post, inverse_of: :subs
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :bigint
#  author_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  # belongs_to :sub, class_name: 'Sub'

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub

  # wyciąga wszystkie komentarze, dlatego, że każdy subkomentarz ma post_id
  has_many :comments

  def comments_by_parent_id
    comments.group_by(&:parent_comment_id)
  end
end

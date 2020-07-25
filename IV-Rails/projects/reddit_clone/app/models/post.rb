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

  # zawsze waliduje obecność obiektów powiązanych ale z domyślnym tekstem o walidacji

  #   validates :subs, presence: { message: 'must have at least one sub' }
  # wyciąga wszystkie komentarze, dlatego, że każdy subkomentarz ma post_id
  has_many :comments
  has_many :post_subs, inverse_of: :post # dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub, inverse_of: :posts

  belongs_to :author, class_name: 'User', foreign_key: 'author_id', inverse_of: :posts

  # Using polymorphic assocations without a concern
  # has_many :user_votes, as: :votable, class_name: "UserVote"

  # wersje niezoptymalizowna o asocjację do autora
  def comments_by_parent_id
    comments.group_by(&:parent_comment_id)
  end

  #  def comments_by_parent
  # comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

  # self.comments.includes(:author).each do |comment|
  #   comments_by_parent[comment.parent_comment_id] << comment
  # end

  # comments_by_parent
  # end

  # Without a concern, we have to write a #votes method for each votable class
  # def votes
  #   self.user_votes.sum(:value)
  # end
end

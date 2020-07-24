# frozen_string_literal: true

# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  sub_id     :bigint
#  post_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
  # post moze należeć tylko raz do danego tematu
  validates :post_id, uniqueness: { scope: :sub_id }

  belongs_to :sub
  belongs_to :post
end

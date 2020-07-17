# frozen_string_literal: true

class PostSub < ApplicationRecord
  # post moze należeć tylko raz do danego tematu
  validates :post_id, uniqueness: { scope: :sub_id }

  belongs_to :sub
  belongs_to :post
end

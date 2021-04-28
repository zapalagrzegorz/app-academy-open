# frozen_string_literal: true

class Toy < ApplicationRecord
  #
  # validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
  # toyable rozumiem jako skrót dla toyable_id, toyable_type

  # one toy can belong to at most one toy owner
  validates :name, uniqueness: { scope: [:toyable] }
  belongs_to :toyable, polymorphic: true
end

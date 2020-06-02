# frozen_string_literal: true

class Cat < ApplicationRecord
  validates :name, uniqueness: { scope: :birth_date }

  CAT_COLORS = %w[blue pink yellow magenta green grey black].freeze

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w[F M] }
  # inclusion: %w(M F)
end

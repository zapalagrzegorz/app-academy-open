# frozen_string_literal: true

class Cat < ApplicationRecord
  validates :name, uniqueness: { scope: :birth_date }

  CAT_COLORS = %w[blue pink yellow magenta green grey black].freeze

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w[F M] }
  # validades :color, inclusion: { in: CAT_COLORS}
  # inclusion: %w(M F)

  has_many :cat_rental_requests,
           -> { order 'start_date ASC' },
           class_name: 'CatRentalRequest',
           foreign_key: 'cat_id',
           dependent: :destroy

  def age
    time_ago_in_words(birth_date)
 end
end

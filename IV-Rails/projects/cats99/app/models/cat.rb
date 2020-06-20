# frozen_string_literal: true

class Cat < ApplicationRecord
  validates :name, uniqueness: { scope: :birth_date, message: ' of that cat along with birth date is already in system.' }

  CAT_COLORS = %w[blue pink yellow magenta green grey black].freeze

  validates :birth_date, :color, :name, :sex, :description, :owner, presence: true
  validates :sex, inclusion: { in: %w[F M] }
  # validades :color, inclusion: { in: CAT_COLORS}
  # inclusion: %w(M F)

  belongs_to :owner,
             class_name: 'User',
             foreign_key: 'user_id'

  has_many :cat_rental_requests,
           -> { order 'start_date ASC' },
           class_name: 'CatRentalRequest',
           foreign_key: 'cat_id',
           dependent: :destroy

  has_many :pending_cat_rental_requests,
           -> { where status: 'PENDING' },
           class_name: 'CatRentalRequest',
           foreign_key: 'cat_id',
           dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end

  def owned_by_current_user?
    true if current_user.id == user_id
  end

  # def
  #   request.status == "PENDING"
  # end
end

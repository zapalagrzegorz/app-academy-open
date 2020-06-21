# frozen_string_literal: true

class Cat < ApplicationRecord
  CAT_COLORS = %w[blue pink yellow magenta green grey black].freeze

  validates :birth_date, :color, :name, :sex, :description, :owner, presence: true
  # validates :color, inclusion: CAT_COLORS, unless: -> { color.blank? }

  validates :sex, inclusion: { in: %w[F M] }, unless: -> { sex.blank? }
  validates :color, inclusion: { in: CAT_COLORS }, unless: -> { color.blank? }
  validates :name, uniqueness: { scope: :birth_date, message: ' of that cat along with birth date is already in system.' }

  # validate :birth_date_in_the_past, if: -> { birth_date }
  #
  # validates :sex, inclusion: { in: %w[F M] }, unless: Proc.new { |a| a.password.blank? }
  # validates :sex, inclusion: %w(M F), if: -> { sex }

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

  # private

  # def birth_date_in_the_past
  #   if birth_date && birth_date > Time.now
  #     errors[:birth_date] << 'must be in the past'
  #   end
  # end
end

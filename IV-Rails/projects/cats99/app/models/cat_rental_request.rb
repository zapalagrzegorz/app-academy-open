# frozen_string_literal: true

class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, :status, presence: true

  validates :status, inclusion: { in: %w[PENDING APPROVED DENIED] }

  validate does_not_overlap_approved_request

  # validates :overlapping_requests
  # inclusion: %w(M F)
  #   Add associations between CatRentalRequest and Cat.
  # Make sure that when a Cat is deleted, all of its rental requests are also deleted. Use dependent: :destroy.
  belongs_to :cat, class_name: 'Cat', foreign_key: 'cat_id'

  def overlapping_requests
    cat.cat_rental_requests
       .where('start_date BETWEEN :start_date AND :end_date OR end_date BETWEEN :start_date AND :end_date', start_date: start_date, end_date: end_date)
       .where.not(id: id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.exists?
      errors[:start_or_end_date] << '- at least one of them overlaps with already accepted rent request'
    end
  end
end

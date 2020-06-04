# frozen_string_literal: true

class CatRentalRequest < ApplicationRecord
  STATUS_STATES = %w[APPROVED DENIED PENDING].freeze

  validates :start_date, :end_date, :status, presence: true

  validates :status, inclusion: { in: %w[PENDING APPROVED DENIED] }

  validate :does_not_overlap_approved_request

  # validates :overlapping_requests
  # inclusion: %w(M F)
  #   Add associations between CatRentalRequest and Cat.
  # Make sure that when a Cat is deleted, all of its rental requests are also deleted. Use dependent: :destroy.
  belongs_to :cat, class_name: 'Cat', foreign_key: 'cat_id'

  def overlapping_requests
    CatRentalRequest
      .where('start_date BETWEEN :start_date AND :end_date OR end_date BETWEEN :start_date AND :end_date', start_date: start_date, end_date: end_date)
      .where(cat_id: cat_id)
      .where.not(id: id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    # debugger
    # return if self.denied?

    #     unless overlapping_approved_requests.empty?
    # errors[:base] <<
    # 'Request conflicts with existing approved request'
    # end
    if overlapping_approved_requests.exists?
      errors[:start_or_end_date] << '- at least one of them overlaps with already accepted rent request'
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def approve!
    # gdyby jednak użytkownik wysłał wniosek o zatwierdzenie odrzuconego wniosku
    # raise 'not pending' unless status == 'PENDING'

    if overlapping_pending_requests.exists?
      ActiveRecord::Base.transaction do
        update(status: 'APPROVED')
        overlapping_pending_requests.update_all(status: 'DENIED')
      end
    else
      update(status: 'APPROVED')
    end
  end

  def deny!
    update(status: 'DENIED')
  end

  # private
  # def start_must_come_before_end
  #   return if start_date < end_date
  #   errors[:start_date] << 'must come before end date'
  #   errors[:end_date] << 'must come after start date'
  # end
end

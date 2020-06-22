# frozen_string_literal: true

class CatRentalRequest < ApplicationRecord
  # freeze renders constants immutable
  STATUS_STATES = %w[APPROVED DENIED PENDING].freeze

  # after_initialize :assign_pending_status

  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w[PENDING APPROVED DENIED] }
  #   validates :status, inclusion: STATUS_STATES
  validate :does_not_overlap_approved_request
  # validate :start_must_come_before_end

  belongs_to :cat, class_name: 'Cat', foreign_key: 'cat_id'
  belongs_to :requester, class_name: 'User', foreign_key: 'user_id'

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
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

  # def approved?
  #   self.status == 'APPROVED'
  # end

  # def denied?
  #   self.status == 'DENIED'
  # end

  private

  # set field as default
  # def assign_pending_status
  #   self.status ||= 'PENDING'
  # end

  # We want:
  # 1. A different request
  # 2. That is for the same cat.
  # 3. That overlaps.
  def overlapping_requests
    CatRentalRequest
      .where.not(id: id)
      .where(cat_id: cat_id)
      .where('start_date BETWEEN :start_date AND :end_date OR end_date BETWEEN :start_date AND :end_date', start_date: start_date, end_date: end_date)
  end

  # do not trust user form data
  # def start_must_come_before_end
  #   errors[:start_date] << 'must specify a start date' unless start_date
  #   errors[:end_date] << 'must specify an end date' unless end_date
  #   errors[:start_date] << 'must come before end date' if start_date > end_date
  # end
end

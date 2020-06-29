# frozen_string_literal: true

class Album < ApplicationRecord
  validates :title, :year, presence: true
  validates :studio, inclusion: { in: [true, false], message: 'Type of album is required' }, unless: -> { studio.blank? }

  validates :year, numericality: { only_integer: true, greater_than: 1940 }, unless: -> { year.blank? }
  # validate year_cannot_be_in_future

  belongs_to :band

  has_many :tracks, dependent: :destroy

  def year_cannot_be_in_future(year)
    errors[:year] = "Album's year cannot be in future" if year > Time.year
  end
end

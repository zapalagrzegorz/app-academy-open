# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :band
  has_many :tracks, dependent: :destroy

  validates :title, :year, presence: true
  validates :studio, inclusion: { in: [true, false], message: 'Type of album is required' }, unless: -> { studio.blank? }
  validates :year, numericality: { only_integer: true, greater_than: 1940 }, unless: -> { year.blank? }
  validate :year_cannot_be_in_future
  # dla indeksu na dwóch kolumnach
  # validates :name, uniqueness: { scope: :band_id }

  # TODO
  def year_cannot_be_in_future
    errors[:year] << 'of the album cannot be in future' if year > Time.now.year
  end

  # zapewnij default'owe wartości

  # after_initialize :set_defaults

  # def set_defaults
  #   self.live ||= false
  # end
end

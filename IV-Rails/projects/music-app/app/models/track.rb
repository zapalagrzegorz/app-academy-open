# frozen_string_literal: true

class Track < ApplicationRecord
  validates :title, :regular, presence: true
  # validates :lyrics

  validates :ord, presence: { message: 'Track number must be present' }

  validates :ord, numericality: { only_integer: true, greater_than: 0, less_than: 200 }, unless: -> { ord.blank? }

  validates :regular, inclusion: [true, false], unless: -> { regular.blank? }

  # walidacja dla indeksu na dwóch kolumnach
  # validates :ord, uniqueness: { scope: :album_id }

  belongs_to :album
  has_many :notes, dependent: :destroy

  # TO_DO - has_one throogh
  #   has_one :band,
  # through: :album,
  # source: :band

  def band
    Band.find_by(id: album.band_id)
  end

  # skoro jest w bazie default to tutaj też?
  # after_initialize :set_defaults

  # def set_defaults
  #   self.bonus ||= false
  # end
end

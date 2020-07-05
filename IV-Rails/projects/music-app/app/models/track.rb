# frozen_string_literal: true

class Track < ApplicationRecord
  validates :title, :regular, presence: true

  validates :ord, presence: { message: 'Track number must be present' }

  validates :ord, numericality: { only_integer: true, greater_than: 0, less_than: 200 }, unless: -> { ord.blank? }

  validates :regular, inclusion: [true, false], unless: -> { regular.blank? }

  has_many :notes, dependent: :destroy

  belongs_to :album

  def band
    Band.find_by(id: album.band_id)
  end
end

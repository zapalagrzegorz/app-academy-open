# frozen_string_literal: true

class Band < ApplicationRecord
  validates :name, presence: true
  # name could be unique

  has_many :albums, dependent: :destroy

  has_many :tracks,
           through: :albums,
           source: :tracks
end

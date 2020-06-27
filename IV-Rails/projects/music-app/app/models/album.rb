# frozen_string_literal: true

class Album < ApplicationRecord
  validates :title, :year, :studio, presence: true
  validates :studio, inclusion: [true, false], unless: -> { studio.blank? }

  belongs_to :band
end

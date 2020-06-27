# frozen_string_literal: true

class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums
end

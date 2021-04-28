# frozen_string_literal: true

class Note < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :track
end

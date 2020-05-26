# frozen_string_literal: true

class ArtworkShare < ApplicationRecord
  # validates :artwork_id, :viewer_id, presence: true
  # Ensure that a user cannot have a single Artwork shared with them more than once.
  validates :artwork_id, uniqueness: { scope: :viewer_id }
  #   validates :artwork_id, uniqueness: { scope: :viewer_id }
  validates :artwork_id, :viewer_id, presence: true

  belongs_to :viewer,
             foreign_key: 'viewer_id',
             class_name: 'User'

  belongs_to :artwork
end

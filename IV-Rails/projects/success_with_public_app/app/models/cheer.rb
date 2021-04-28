# frozen_string_literal: true

# == Schema Information
#
# Table name: cheers
#
#  id         :bigint           not null, primary key
#  giver_id   :bigint           not null
#  goal_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cheer < ApplicationRecord

  CHEER_LIMIT = 12
  ##
  # Don't let others change the limit!
  ##
  CHEER_LIMIT.freeze
  
  # Ensure that a user cannot have a single Artwork shared with them more than once.
  # validates :artwork_id, uniqueness: { scope: :viewer_id }
  validates :goal_id, uniqueness: { scope: :giver_id }

  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id'

  belongs_to :goal
end

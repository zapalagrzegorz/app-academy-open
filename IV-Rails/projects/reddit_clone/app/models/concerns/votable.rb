# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  # execute code at the time they are included
  included do
    has_many :user_votes,
             as: :votable,
             class_name: 'UserVote',
             dependent: :destroy
  end

  def votes
    user_votes.sum(:value)
  end
end

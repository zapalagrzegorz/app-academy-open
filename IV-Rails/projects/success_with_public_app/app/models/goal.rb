# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :text
#  completed  :boolean          default(FALSE)
#  private    :boolean          default(FALSE)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Goal < ApplicationRecord
  include Commentable

  validates :title, presence: true

  validates :title, length: { minimum: 6, maximum: 50 }
  validates :completed,
            inclusion: { in: [true, false], message: 'Completed field can be only true/false value' }, unless: -> { :completed.blank? }

  validates :private,
            inclusion: { in: [true, false], message: 'Private field can be only true/false' }, unless: -> { :private.blank? }

  belongs_to :user

  has_many :cheers, class_name: 'Cheer'

  def cheered_by?(user)
    cheers.exists?(giver_id: user.id)
  end
end

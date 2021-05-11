# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :title, :body, presence: true
  validates :done, inclusion: { in: [true, false] }

  has_many :steps, dependent: :destroy

  has_many :taggings
  has_many :tags, through: :taggings, source: :tag

  # take care of setting the tags for a specific todo. It should create the tag names sent up that do not already exist and find the ones that do. It should remove old taggings and create new ones where appropriate.
  def tag_names=(tag_names)
    # self to tutaj instancja modelu
    self.tags = tag_names.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end
end

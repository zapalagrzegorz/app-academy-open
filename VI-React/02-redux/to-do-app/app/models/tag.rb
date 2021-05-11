# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true

  has_many :taggings, class_name: 'Tagging', dependent: :destroy
  has_many :todos, through: :taggings, source: :todo
end

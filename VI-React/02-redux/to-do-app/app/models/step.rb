# frozen_string_literal: true

class Step < ApplicationRecord
  validates :title, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :todo, class_name: "Todo"
end

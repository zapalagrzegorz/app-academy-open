# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.belongs_to :user, index: { unique: false }, foreign_key: true
      t.belongs_to :answer_choice, index: { unique: false }, foreign_key: true
      t.timestamps
    end
  end
end

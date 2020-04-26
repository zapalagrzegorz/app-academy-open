# frozen_string_literal: true

class CreateAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_choices do |t|
      t.text :text
      t.belongs_to :question, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end

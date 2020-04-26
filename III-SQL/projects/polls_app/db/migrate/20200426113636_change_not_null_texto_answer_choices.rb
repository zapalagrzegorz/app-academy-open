# frozen_string_literal: true

class ChangeNotNullTextoAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    change_column_null :answer_choices, :text, false
  end
end

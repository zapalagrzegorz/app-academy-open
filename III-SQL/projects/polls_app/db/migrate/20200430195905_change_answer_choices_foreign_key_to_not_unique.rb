# frozen_string_literal: true

class ChangeAnswerChoicesForeignKeyToNotUnique < ActiveRecord::Migration[5.2]
  def change
    remove_index(:answer_choices, name: 'index_answer_choices_on_question_id')
    add_index(:answer_choices, :question_id, name: 'index_answer_choices_on_question_id')
  end
end

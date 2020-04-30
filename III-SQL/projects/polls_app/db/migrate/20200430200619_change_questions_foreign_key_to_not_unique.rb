# frozen_string_literal: true

class ChangeQuestionsForeignKeyToNotUnique < ActiveRecord::Migration[5.2]
  def change
    remove_index(:questions, name: 'index_questions_on_poll_id')
    add_index(:questions, :poll_id, name: 'index_questions_on_poll_id')
  end
end

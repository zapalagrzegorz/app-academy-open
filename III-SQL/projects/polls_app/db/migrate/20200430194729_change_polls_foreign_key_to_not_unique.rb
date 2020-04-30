# frozen_string_literal: true

class ChangePollsForeignKeyToNotUnique < ActiveRecord::Migration[5.2]
  def change
    remove_index(:polls, name: 'index_polls_on_user_id')
    add_index(:polls, :user_id, name: 'index_polls_on_user_id')
  end
end

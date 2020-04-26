# frozen_string_literal: true

class ChangeNotNullTitleToPolls < ActiveRecord::Migration[5.2]
  def change
    change_column_null :polls, :title, false
  end
end

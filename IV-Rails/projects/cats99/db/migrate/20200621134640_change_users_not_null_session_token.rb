# frozen_string_literal: true

class ChangeUsersNotNullSessionToken < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :session_token, false
  end
end

# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class User
  attr_reader :fname, :lname

  def initialize(props)
    @fname = props['fname']
    @lname = props['lname']
  end

  def self.find_by_name(first, last)
    user = QuestionsDatabase.instance.execute(<<-SQL, first, last)
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL
    # debugger
    return nil unless user.first

    User.new(user.first)
  end
  #  User::find_by_name(fname, lname)
  #   User#authored_questions (use Question::find_by_author_id)
  #   User#authored_replies (use Reply::find_by_user_id)
end

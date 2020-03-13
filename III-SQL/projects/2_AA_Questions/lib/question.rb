# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class Question
  attr_reader :title, :body, :user_id

  def initialize(props)
    @title = props['title']
    @body = props['body']
    @id = props['user_id']
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    # debugger
    return nil unless question.first

    Question.new(question.first)
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

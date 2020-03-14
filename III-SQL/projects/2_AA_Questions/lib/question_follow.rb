# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class Question_follow
  attr_reader :question_id, :user_id

  def initialize(props)
    @question_id = props['question_id']
    @user_id = props['user_id']
  end

  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL

    return nil unless question_follow.first

    Question_follow.new(question_follow.first)
  end

  def self.followers_for_question_id(id)
    users = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT users.id, users.fname, users.lname
      FROM question_follows
      JOIN users ON question_follows.user_id = users.id
      WHERE question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end
end

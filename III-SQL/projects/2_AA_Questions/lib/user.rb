# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'question_follow.rb'

# Obiekt użytkownika serwisu
class User
  attr_reader :fname, :lname

  def initialize(props)
    @id = props['id']
    @fname = props['fname']
    @lname = props['lname']
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    # debugger
    return nil unless user.first

    User.new(user.first)
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

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end


end

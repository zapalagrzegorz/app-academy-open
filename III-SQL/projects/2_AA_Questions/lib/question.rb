# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class Question
  attr_reader :title, :body, :user_id

  def initialize(props)
    @id = props['id']
    @title = props['title']
    @body = props['body']
    @user_id = props['user_id']
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

  def self.find_by_author_id(id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE user_id = ?
    SQL

    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    # debugger
    Reply.find_by_question_id(@id)
  end
end

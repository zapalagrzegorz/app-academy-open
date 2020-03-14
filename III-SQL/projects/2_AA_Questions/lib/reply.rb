# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt odpowiedzi na wątek
class Reply
  attr_reader :question_id, :parent_reply_id, :author_id, :body

  def initialize(props)
    @question_id = props['question_id']
    @parent_reply_id = props['parent_reply_id']
    @author_id = props['author_id']
    @body = props['body']
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    return nil unless reply.first

    Reply.new(reply.first)
  end

  def self.find_by_user_id(id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE author_id = ?
    SQL

    return nil if replies.empty?

    replies.map { |reply| Reply.new(reply) }
  end

  # All replies to the question at any depth.
  def self.find_by_question_id(id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL

    return nil if replies.empty?

    replies.map { |reply| Reply.new(reply) }
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    return Reply.find_by_id(@parent_reply_id) if @parent_reply_id

    nil
  end

  def child_replies
    child_replies = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply_id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    return nil if child_replies.empty?

    child_replies.map { |reply| Reply.new(reply) }
  end
end

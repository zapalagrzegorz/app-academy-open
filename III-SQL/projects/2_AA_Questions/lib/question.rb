# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'
require_relative 'question_like'

# Obiekt użytkownika serwisu
class Question
  attr_reader :title, :body, :user_id, :id

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

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(props)
    @id = props['id']
    @title = props['title']
    @body = props['body']
    @user_id = props['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    # debugger
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end

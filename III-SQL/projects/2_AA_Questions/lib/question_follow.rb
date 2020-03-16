# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class QuestionFollow
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

    QuestionFollow.new(question_follow.first)
  end

  def self.followers_for_question_id(id)
    users = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT users.id, users.fname, users.lname
      FROM question_follows
      JOIN users ON question_follows.user_id = users.id
      WHERE question_id = ?
    SQL

    return nil if users.empty?

    users.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  questions.id, questions.title, questions.body, questions.user_id
      FROM question_follows
      JOIN users ON question_follows.user_id = users.id
      JOIN questions ON questions.id = question_follows.question_id
      WHERE question_follows.user_id = ?
    SQL

    return nil unless questions.first

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(num)
    return nil if !num.is_a?(Integer) || !num.positive?

    questions = QuestionsDatabase.instance.execute(<<-SQL, num)
      SELECT  questions.id, questions.title, questions.body, questions.user_id, COUNT(*) as followers_num
      FROM question_follows
      JOIN questions ON questions.id = question_follows.question_id
      GROUP BY questions.id
      ORDER BY followers_num DESC
      LIMIT ?
    SQL

    questions.map { |question| Question.new(question) }
  end
end

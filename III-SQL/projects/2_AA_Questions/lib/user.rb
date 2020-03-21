# frozen_string_literal: true

require 'byebug'
require_relative 'model_base'
require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'question_follow.rb'
# Obiekt użytkownika serwisu
class User < ModelBase
  attr_accessor :fname, :lname, :id

  def initialize(props)
    @id = props['id']
    @fname = props['fname']
    @lname = props['lname']
  end

  def self.find_by_name(first, last)
    user = QuestionsDatabase.instance.get_first_row(<<-SQL, first, last)
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL

    return nil if user.nil?

    User.new(user)
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

  # Avg number of likes for a User's questions.
  def average_karma
    QuestionsDatabase.instance.get_first_value(<<-SQL, @id)
      SELECT CAST(COUNT(question_likes.question_id) AS FLOAT) / COUNT(*)  as karma
      FROM questions
      LEFT JOIN question_likes ON question_likes.question_id =  questions.id
      WHERE questions.user_id = ?
    SQL
  end

  def save
    if @id.nil?

      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
      SQL

      # insert returns empty array
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
      id = ?
      SQL
    end
  end
end

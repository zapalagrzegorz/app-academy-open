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

  # Avg number of likes for a User's questions.
  def average_karma
    # First, write a single query that returns two things: the number of questions asked by a user and the number of likes on those questions.

    # user questions

    # likes number
    questions = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT COUNT(*) as questions_num, COUNT(question_likes.id) as likes_num
      FROM questions
      LEFT JOIN question_likes ON question_likes.question_id =  questions.id
      WHERE questions.user_id = ?
    SQL

    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT COUNT(questions.id) as num_likes, COUNT(questions.)
      FROM question_likes
      JOIN questions ON question_likes.question_id =  questions.id
      GROUP BY question_likes.question_id
      ORDER BY num_likes DESC
    SQL
  end
end

# Average Karma is pretty tough. Here are some hints:

#     I used a LEFT OUTER JOIN to combine the questions and question_likes table.
#         You need questions so you can filter by the author, and you need question_likes so you can count the number of likes.
#     I used a COUNT(DISTINCT(...)) to count the number of questions.
#         Note that a question that is liked multiple times will be repeated in the joined table.
#     I used a COUNT(column) to count the number of non-NULL entries in a column.
#         Note that a question that is never liked will take up one row in the joined table. How do we use COUNT(column) to not count this toward the total number of likes?

# Next, divide the number of likes by the number of questions. Because COUNT returns two integers, and because integer division rounds down (3 / 2 == 1), we need to CAST one of the numbers to FLOAT. We can do this like so: CAST(value AS FLOAT).

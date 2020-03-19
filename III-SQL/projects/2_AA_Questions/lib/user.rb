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
    user = QuestionsDatabase.instance.execute(<<-SQL, first, last)
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL

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
    # First, write a single query that returns two things: the number of
    # questions asked by a user and the number of likes on those questions.

    # user questions

    # likes number
    questions = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT CAST(COUNT(question_likes.question_id) AS FLOAT) / COUNT(*)  as karma
      FROM questions
      LEFT JOIN question_likes ON question_likes.question_id =  questions.id
      WHERE questions.user_id = ?
    SQL

    questions.first['karma']
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

    # attr_accessor - czy to oznacza customowy setter dla pól?
  end

  #   So far we haven't created any new records; we've only been parsing data fetched from the database and performing queries.

  # Let's see how to create a new object. Let's add a #save method to our models (User, Question and Reply are enough to get the point). If the model has not been saved (its id attribute is nil), we should perform an INSERT of the record's fields into the DB. After the insert, we can use SQLite3::Database#last_insert_row_id to get the newly issued id for the inserted row. Save this in an @id instance variable in your object. Future calls to #save on this object should issue an UPDATE.

  # If a model already exists in the DB, it should have a non-nil id attribute. Calls to #save should issue an UPDATE SQL command for the row with the object's id. Update all the columns with the current version of the values in your object.

  # The user should be able to get and set the attributes on the object you hand them through reader and writer methods (attr_accessor).
end

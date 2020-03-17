# frozen_string_literal: true

require 'byebug'
require_relative 'questions_database.rb'

# Obiekt użytkownika serwisu
class QuestionLike
  attr_reader :user_id, :question_id

  def initialize(props)
    @question_id = props['question_id']
    @user_id = props['user_id']
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL

    return nil unless question_like.first

    QuestionLike.new(question_like.first)
  end

  # powinno zwracać user'ów
  def self.likers_for_question_id(id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT users.id, users.fname, users.lname
      FROM question_likes
      JOIN users ON question_likes.user_id = users.id
      WHERE question_likes.id = ?
    SQL

    return nil unless likers.first


    likers.map { |liker| User.new(liker) }

    
  end

  def self.num_likes_for_question_id(id)
    num_likers = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT COUNT(*)
      FROM question_likes
      WHERE question_likes.id = ?
    SQL

    num_likers
  end

  def liked_questions_for_user_id
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT questions.id, questions.title, questions.body, questions.user_id
      FROM question_likes
      JOIN questions ON question_likes.question_id =  questions.id
      WHERE question_likes.user_id = ?
    SQL

    return nil unless questions.first


    questions.map { |question| Question.new(question) }
  end

  def most_liked_questions() 
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT questions.id, questions.title, questions.body, questions.user_id, COUNT(questions.id) as num_likes
      FROM question_likes
      JOIN questions ON question_likes.question_id =  questions.id
      GROUP BY question_likes.question_id
      ORDER BY num_likes DESC 
    SQL

    questions.map { |question| Question.new(question) }
  end
end

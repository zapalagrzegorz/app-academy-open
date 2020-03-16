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
end

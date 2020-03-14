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
end

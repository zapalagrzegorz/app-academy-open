# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  answer_choice_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validate :respondent_already_answered?

  belongs_to :answer_choice,
             primary_key: :id,
             foreign_key: :answer_choice_id,
             class_name: 'AnswerChoice'

  belongs_to :user,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: 'User'

  has_one :question,
          through: :answer_choice,
          source: :question

  # return all the other Response objects for the same Question.
  # exclude yourself
  # private

  def sibling_responses
    question.responses.where.not(id: id)
  end

  # see if any sibling exists? with the same respondent_id
  def respondent_already_answered?
    unless sibling_responses.where(user_id: user_id).empty?
      errors[:user_id] << 'this user has already answered this question'
    end
  end
  # User Can't Create Multiple Responses To The Same Question
end

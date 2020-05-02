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
  # validate :not_duplicate_response
  # Only run validation if there is an answer_choice that exists
  # (otherwise this validation raises an error)

  # czy answer_choice może być nil, skoro rails 5 automatycznie validuje asocjacje belongs_to
  validate :not_duplicate_response, unless: -> { answer_choice.nil? }

  validate :impoved_respondent_is_not_author_poll?

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

  # private

  # return all the other Response objects for the same Question.
  # exclude yourself
  # private
  def sibling_responses
    # exclude yourself
    # load questions, then load responses
    question.responses.where.not(id: id)
  end

  # see if any sibling response exists with the same respondent_id
  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  # User Can't Create Multiple Responses To The Same Question
  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << 'this user has already answered this question'
    end
    # unless sibling_responses.where(user_id: user_id).empty?
  end

  # Author Can't Respond To Own Poll
  # The simplest way is to use associations to traverse from a Response object back to the AnswerChoice, to the Question, and finally the Poll. You can then verify whether the poll's author is the same as the respondent_id. This may involve multiple queries, but we will later improve this. Don't spend too much time trying to refactor the method right now. Many students have gone down this deep, dark rabbit hole and you'll have time to explore it later.
  def respondent_is_not_author_poll?
    #
    # respondend.id == author.id

    if question.poll.author.id == user.id
      errors[:user_id] << 'author should not answer to his/her poll'
    end
  end

  def impoved_respondent_is_not_author_poll?
    #
    # respondend.id == author.id
    author_id = Poll.joins(:questions)
                    .where('questions.id = ?', question.id)
                    .pluck('polls.user_id')
                    .first
    # .author.id

    # .joins(questions: :answer_choices)
    # .where('answer_choices.id = ?', self.answer_choice_id)
    # .pluck('polls.author_id')
    # .first

    if author_id == user.id
      errors[:user_id] << 'author should not answer to his/her poll via improved validation'
    end
  end
end

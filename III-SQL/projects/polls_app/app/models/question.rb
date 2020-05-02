# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text
#  poll_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll,
             primary_key: :id,
             foreign_key: :poll_id,
             class_name: 'Poll'

  has_many :answer_choices,
           primary_key: :id,
           foreign_key: :question_id,
           class_name: 'AnswerChoice'

  #  bo ważne są odpowiedzi
  has_many :responses,
           through: :answer_choices,
           source: :responses

  # returns a hash of choices and counts like so:
  def results_n_plus_1
    results = {}

    answer_choices.each do |answer_choice|
      answer = answer_choice.text
      count = answer_choice.responses.count
      results[answer] = count
      # responses
    end

    results
  end

  def results_2_queries
    # 2-queries; all responses transferred:
    results = {}
    answer_choices.includes(:responses).each do |ac|
      results[ac.text] = ac.responses.length
    end
    results
  end

  def results
    results = {}
    # left outer joins aby każda potencjalna odpowiedź answer_choice, nawet bez pasujacej odpowiedzi (responses), była wylistowana
    # COUNT(responses.id) ma na celu pominięcie NULLi po stronie responses, policz tylko istniejące odpowiedzi
    answers = answer_choices.select('answer_choices.text, answer_choices.id, COUNT(responses.id) AS answer_count').left_outer_joins(:responses).group('answer_choices.id')

    answers.each do |answer|
      results[answer.text] = answer.answer_count
    end

    results

    # acs.inject({}) do |results, ac|
    #   results[ac.text] = ac.num_responses
    # end
  end

  # First, do this with an N+1 query. Get all the answer_choices for the question, then call responses.count for each.
end

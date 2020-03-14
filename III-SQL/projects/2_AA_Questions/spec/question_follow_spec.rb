# frozen_string_literal: true

require 'questions_database'
require 'question_follow'
require 'user'

describe Question_follow do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  let(:question_follow) { Question_follow.find_by_id(1) }

  describe '::find_by_id' do
    # user =
    let(:not_found_question_follow) { Question_follow.find_by_id(-1) }

    context 'when question_follow is found' do
      it 'generates question_follow instance' do
        expect(question_follow).to be_instance_of(Question_follow)
      end

      it 'generates question_follow with user_id' do
        expect(question_follow.user_id).to eq(1)
      end

      it 'generates question_follow with question_id' do
        expect(question_follow.question_id).to eq(1)
      end
    end

    context 'when question is not in db' do
      it 'returns nil' do
        expect(not_found_question_follow).to be_nil
      end
    end
  end

  #  will return an array of User objects!
  describe '::followers_for_question_id' do
    let(:followers_for_question_id) { Question_follow.followers_for_question_id(1) }

    it 'returns an array of Users' do
      expect(followers_for_question_id).to all be_an(User)
    end

    it 'returns an specified length of array of Users' do
      expect(followers_for_question_id.length).to eq(5)
    end
  end
  #  QuestionFollow::followers_for_question_id(question_id)
  #       This will return an array of User objects!
  #   QuestionFollow::followed_questions_for_user_id(user_id)
  #       Returns an array of Question objects.
end

# frozen_string_literal: true

require 'questions_database'
require 'question_follow'
require 'user'

describe QuestionFollow do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  let(:question_follow) { QuestionFollow.find_by_id(1) }

  describe '::find_by_id' do
    # user =
    let(:not_found_question_follow) { QuestionFollow.find_by_id(-1) }

    context 'when question_follow is found' do
      it 'generates question_follow instance' do
        expect(question_follow).to be_instance_of(QuestionFollow)
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
    let(:followers_for_question_id) { QuestionFollow.followers_for_question_id(1) }

    it 'returns an array of Users' do
      expect(followers_for_question_id).to all be_an(User)
    end

    it 'returns an specified length of array of Users' do
      expect(followers_for_question_id.length).to eq(3)
    end
  end

  # questions that are followed by a user
  describe ':followed_questions_for_user_id' do
    let(:followed_questions_for_user_id) { QuestionFollow.followed_questions_for_user_id(1) }
    let(:no_followed_questions_for_user_id) { QuestionFollow.followed_questions_for_user_id(5) }

    it 'returns an array of Questions' do
      expect(followed_questions_for_user_id).to all be_an(Question)
    end

    it 'returns a specified number Questions' do
      expect(followed_questions_for_user_id.length).to eq(4)
    end

    it 'returns nil once there are no followed questions' do
      expect(no_followed_questions_for_user_id).to be_nil
    end
  end

  # Nie wiem czy mockowanie obiekt do testów miałoby sens
  # QuestionFollow::most_followed_questions(n)
  # Fetches the n most followed questions.
  describe '::most_followed_questions' do
    let(:most_followed_questions) { QuestionFollow.most_followed_questions(3) }

    it 'returns questions.' do
      expect(most_followed_questions).to all be_an(Question)
    end

    it 'returns most followed questions' do
      expect(most_followed_questions.first.followers.length).to eq(3)
    end

    it 'returns nil when no positive integer is given' do
      expect(QuestionFollow.most_followed_questions('a')).to be_nil
      expect(QuestionFollow.most_followed_questions(0)).to be_nil
      expect(QuestionFollow.most_followed_questions(User.find_by_id(1))).to be_nil
    end
  end
end

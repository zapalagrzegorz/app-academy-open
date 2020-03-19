# frozen_string_literal: true

require 'questions_database'
require 'question_like'
require 'user'

describe QuestionLike do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  describe '::find_by_id' do
    let(:question_like) { QuestionLike.find_by_id(1) }
    let(:not_found_question_like) { QuestionLike.find_by_id(-1) }

    context 'when question_like is found' do
      it 'generates question_like instance' do
        expect(question_like).to be_instance_of(QuestionLike)
      end

      it 'generates question_like with user_id' do
        expect(question_like.user_id).to eq(1)
      end

      it 'generates question_like with question_id' do
        expect(question_like.question_id).to eq(1)
      end
    end

    context 'when question is not in db' do
      it 'returns nil' do
        expect(not_found_question_like).to be_nil
      end
    end
  end

  describe ':likers_for_question_id' do
    let(:likers_for_question_id) { QuestionLike.likers_for_question_id(1) }

    it 'returns only users' do
      expect(likers_for_question_id).to all be_an(User)
    end

    it 'returns users who likes the question' do
      users_id = likers_for_question_id.map(&:id)
      expect(users_id).to contain_exactly(1, 2, 3)
    end

    it 'returns nil if there s no likers of question doesn exits' do
      users_id = likers_for_question_id.map(&:id)
      expect(users_id).to contain_exactly(1, 2, 3)
    end
  end

  describe ':num_likes_for_question_id' do
    let(:num_likes_for_question_id) { QuestionLike.num_likes_for_question_id(1) }
    let(:zero_num_likes_for_question_id) { QuestionLike.num_likes_for_question_id(5) }

    it 'returns integer' do
      expect(num_likes_for_question_id).to be_an(Integer)
    end

    it 'returns num likes for question' do
      expect(num_likes_for_question_id).to eq(3)
    end

    it 'returns 0 num likes for question with no likes' do
      expect(zero_num_likes_for_question_id).to eq(0)
    end
  end

  describe ':liked_questions_for_user_id' do
    let(:liked_questions_for_user_id) { QuestionLike.liked_questions_for_user_id(1) }
    let(:no_liked_questions_for_user_id) { QuestionLike.liked_questions_for_user_id(4) }

    it 'returns only Questions' do
      expect(liked_questions_for_user_id).to all be_an(Question)
    end

    it 'returns questions liked by the user' do
      questions = liked_questions_for_user_id.map(&:id)
      expect(questions).to contain_exactly(1, 2, 3, 4)
    end

    it 'returns nil if there re no questions' do
      expect(no_liked_questions_for_user_id).to be_nil
    end
  end

  describe '::most_liked_questions(n)' do
    let(:most_liked_questions) { QuestionLike.most_liked_questions(3) }

    it 'returns only Questions' do
      expect(most_liked_questions).to all be_an(Question)
    end

    it 'returns most liked questions ordered descending' do
      questions = most_liked_questions.map(&:id)
      expect(questions).to contain_exactly(1, 2, 3)
    end
  end
end

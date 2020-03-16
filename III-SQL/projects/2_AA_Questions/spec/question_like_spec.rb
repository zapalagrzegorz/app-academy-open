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

  # QuestionLike::likers_for_question_id(question_id)

  describe ':likers_for_question_id' do
    let(:likers_for_question_id) { QuestionLike.likers_for_question_id(1) }

    it 'returns only users' do
      expect(likers_for_question_id).to all be_an(User)
    end

    it 'returns users who likes the question' do
      users_id = likers_for_question_id.map(&:id)
      expect(users_id).to contain_exactly(1, 2, 3)
    end

    it 'returns users who likes the question' do
      users_id = likers_for_question_id.map(&:id)
      expect(users_id).to contain_exactly(1, 2, 3)
    end
  end

  # QuestionLike::num_likes_for_question_id(question_id)
  # Don't just use QuestionLike::likers_for_question_id and count; do a SQL query to just do this.
  # This is more efficient, since the SQL DB will return just the number, and not the data for each of the likes.
  # QuestionLike::liked_questions_for_user_id(user_id)
end

# frozen_string_literal: true

require 'questions_database'
require 'question_like'

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
end

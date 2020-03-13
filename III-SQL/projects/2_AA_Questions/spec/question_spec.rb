# frozen_string_literal: true

require 'questions_database'
require 'question'
#  User::find_by_name(fname, lname)
#   User#authored_questions (use Question::find_by_author_id)
#   User#authored_replies (use Reply::find_by_user_id)

describe Question do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  describe '::find_by_id' do
    let(:question) { Question.find_by_id(1) }
    # user =
    let(:not_found_question) { Question.find_by_id(-1) }

    context 'when question is found' do
      it 'generates question instance' do
        expect(question).to be_instance_of(Question)
      end

      it 'generates question with title' do
        expect(question.title).to eq('Ile za semestr?')
      end

      it 'generates question with body' do
        expect(question.body).to eq('Chciałbym się dowiedzieć ile kosztuje u was semestr nauki')
      end
    end

    context 'when question is not in db' do
      it 'returns nil' do
        expect(not_found_question).to be_nil
      end
    end
  end
end

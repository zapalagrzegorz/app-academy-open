# frozen_string_literal: true

require 'questions_database'
require 'question'
require 'user'
require 'reply'

describe Question do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  let(:question) { Question.find_by_id(1) }
  describe '::find_by_id' do
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

  describe '::find_by_author_id' do
    let(:questions_by_author) { Question.find_by_author_id(2) }
    let(:no_questions_by_author) { Question.find_by_author_id(4) }

    context 'when questions of author are found' do
      it 'generates only Questions instance' do
        expect(questions_by_author).to all be_an(Question)
      end

      it 'generates expected number of Questions instance' do
        expect(questions_by_author.length).to eq(2)
      end
    end

    context 'when author has no questions' do
      it 'returns nil' do
        expect(no_questions_by_author).to be_nil
      end
    end
  end

  describe '#author' do
    let(:question_author) { Question.find_by_id(1).author }

    it 'generates author of question' do
      expect(question_author).to be_an(User)
    end

    it 'generates specific user-author' do
      expect(question_author.fname).to eq('Grzegorz')
      expect(question_author.lname).to eq('Zapala')
    end
  end

  describe '#replies' do
    let(:question_replies) { Question.find_by_id(1).replies }
    let(:no_question_replies) { Question.find_by_id(4).replies }

    # debugger

    it 'generates replies of question' do
      expect(question_replies).to all be_an(Reply)
    end

    it 'generates expected number of replies' do
      expect(question_replies.length).to eq(2)
    end

    it 'returns nil if there\'s no replies' do
      expect(no_question_replies).to be_nil
    end
  end

  describe '#followers' do
    let(:followers) { question.followers }
    let(:no_followers) { Question.find_by_id(5).followers }

    it 'returns array of users following questions' do
      expect(followers).to all be_an(User)
    end

    it 'returns nil if no users is following' do
      expect(no_followers).to be_nil
    end
  end

  # Simple call to QuestionFollow
  #  Question::most_followed(n)
  describe '::most_followed' do
    let(:most_followed) { Question.most_followed(2) }

    it 'returns first as the most followed question' do
      expect(most_followed.first.id).to eq(1)
    end

    it 'returns second most followed question as second' do
      expect(most_followed[1].id).to eq(2)
    end
  end
end

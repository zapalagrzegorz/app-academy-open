# frozen_string_literal: true

require 'questions_database'
require 'user'

describe User do
  let(:user) { described_class.find_by_id(1) }

  describe '::find_by_id' do
    let(:not_found_user) { described_class.find_by_id(-1) }

    context 'when user is found' do
      it 'generates user instance' do
        expect(user).to be_instance_of(described_class)
      end

      it 'generates user with fname' do
        expect(user.fname).to eq('Grzegorz')
      end

      it 'generates user with lname' do
        expect(user.lname).to eq('Zapala')
      end

      # aa test
      it 'only looks for the first row in the users table' do
        expect(QuestionsDatabase.instance).to receive(:get_first_row).exactly(1).times.and_call_original
        described_class.find_by_id(1)
      end
    end

    context 'when user is not in db' do
      it 'returns nil' do
        expect(not_found_user).to be_nil
      end
    end
  end

  describe '::find_by_name' do
    let(:user) { User.find_by_name('Grzegorz', 'Zapala') }
    let(:not_found_user) { User.find_by_name('cannot', 'find') }

    context 'when user is found' do
      it 'generates user instance ' do
        expect(user).to be_instance_of(User)
      end

      it 'generates user with first name' do
        expect(user.fname).to eq('Grzegorz')
      end

      it 'generates user with last name' do
        expect(user.lname).to eq('Zapala')
      end
    end

    context 'when user is not in db' do
      it 'returns nil' do
        expect(not_found_user).to be_nil
      end
    end
  end

  describe '#authored_questions' do
    let(:authored_questions) { user.authored_questions }
    let(:no_authored_questions) { User.find_by_id(4).authored_questions }

    it 'generates questions of user' do
      expect(authored_questions).to all be_a(Question)
    end

    it 'returns nil when no user questions' do
      expect(no_authored_questions).to be_nil
    end

    # metoda wywołuje metodę statyczną innej klasy
    # Nie ma sensu pisać testów jej poprawności ponownie
    # trzeba zapytać czy obca metoda została wywołana
    # nie jest istotna wartość zwrotna - tylko wywołanie metody
    # Rspec mocks
    # class_double
    # as_stubbed_const
    let(:question) { class_double('Question').as_stubbed_const }

    it 'calls Question::find_by_author_id' do
      expect(question).to receive(:find_by_author_id).with(user.id)
      user.authored_questions
    end
  end

  describe '#authored_replies' do
    let(:authored_replies) { user.authored_replies }
    let(:no_authored_replies) { User.find_by_id(4).authored_replies }

    let(:reply) { class_double('Reply').as_stubbed_const }

    it 'calls Reply::find_by_user_id' do
      expect(reply).to receive(:find_by_user_id).with(1)
      user.authored_replies
    end

    it 'generates user\'s replies' do
      expect(authored_replies).to all be_a(Reply)
    end

    it 'generates expected number of replies' do
      expect(authored_replies.length).to eq(1)
    end

    it 'returns nil when user has no replies' do
      expect(no_authored_replies).to be_nil
    end
  end

  describe '#followed_questions' do
    let(:followed_questions) { user.followed_questions }
    let(:no_followed_questions) { User.find_by_id(5).followed_questions }
    let(:questionfollow) { class_double('QuestionFollow').as_stubbed_const }

    it 'returns Questions followed by user' do
      expect(followed_questions).to all be_an(Question)
    end

    it 'returns specified number of Questions followed by user' do
      expect(followed_questions.length).to eq(4)
    end

    it 'returns nil if there s no questions followed' do
      expect(no_followed_questions)
    end

    it 'calls QuestionFollow::followed_questions_for_user_id' do
      expect(questionfollow).to receive(:followed_questions_for_user_id).with(user.id)
      user.followed_questions
    end
  end

  describe '#liked_questions' do
    let(:liked_questions) { user.liked_questions }
    let(:no_liked_questions) { User.find_by_id(5).liked_questions }
    let(:questionlike) { class_double('QuestionLike').as_stubbed_const }

    it 'returns only Questions' do
      expect(liked_questions).to all be_an(Question)
    end

    it 'returns questions liked by the user' do
      questions = liked_questions.map(&:id)
      expect(questions).to contain_exactly(1, 2, 3, 4)
    end

    it 'returns nil if there re no questions' do
      expect(no_liked_questions).to be_nil
    end

    it 'calls QuestionLike::liked_questions_for_user_id' do
      expect(questionlike).to receive(:liked_questions_for_user_id).with(user.id)
      user.liked_questions
    end
  end

  describe '#average_karma' do
    let(:average_karma) { User.find_by_id(3).average_karma }
    it 'returns number - float' do
      expect(average_karma).to be_a(Float)
    end

    it 'returns some specific float number for user' do
      expect(average_karma).to eq(0.5)
    end

    it 'only hits the database once' do
      user = described_class.find_by_id(2)
      expect(QuestionsDatabase.instance).to receive(:get_first_value).exactly(1).times.and_call_original
      user.average_karma
    end
  end

  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  describe '#save' do
    it 'saves a new record in DB' do
      expect(described_class.new('fname' => 'Iks', 'lname' => 'Igrekowski').save).to eq(6)
    end

    it 'updates a new record in DB' do
      new_user = User.new('fname' => 'Iks', 'lname' => 'Igrekowski')
      new_user_id = new_user.save
      new_user.fname = 'Grzegorz'
      new_user.save

      expect(described_class.find_by_id(new_user_id).fname).to eq('Grzegorz')
    end
  end
end

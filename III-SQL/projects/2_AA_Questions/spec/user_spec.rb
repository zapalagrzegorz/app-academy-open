# frozen_string_literal: true

require 'questions_database'
require 'user'
#  User::find_by_name(fname, lname)
#   User#authored_questions (use Question::find_by_author_id)
#   User#authored_replies (use Reply::find_by_user_id)

describe User do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  let(:user) { User.find_by_id(1) }
  describe '::find_by_id' do
    let(:not_found_user) { User.find_by_id(-1) }

    context 'when user is found' do
      it 'generates user instance' do
        expect(user).to be_instance_of(User)
      end

      it 'generates user with fname' do
        expect(user.fname).to eq('Grzegorz')
      end

      it 'generates user with lname' do
        expect(user.lname).to eq('Zapala')
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
    # user =
    let(:not_found_user) { User.find_by_name('cannot', 'find') }

    context 'when user is found' do
      it 'generates user instance for found user ' do
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
  end

  describe '#authored_replies' do
    let(:authored_replies) { user.authored_replies }
    let(:no_authored_replies) { User.find_by_id(4).authored_replies }

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

    it 'returns Questions followed by user' do
      expect(followed_questions).to all be_an(Question)
    end

    it 'returns specified number of Questions followed by user' do
      expect(followed_questions.length).to eq(4)
    end

    it 'returns nil if there s no questions followed' do
      expect(no_followed_questions)
    end
  end

  describe '#liked_questions' do
    let(:liked_questions) { user.liked_questions(1) }
    let(:no_liked_questions) { user.liked_questions(5) }
    
    it 'returns only Questions'
      expect(liked_questions).to all be_an(Question)
    end

    it 'returns questions liked by the user' do
      questions = liked_questions.map(&:id)
      expect(questions).to contain_exactly(1, 2, 3, 4)
    end

    it 'returns nil if there re no questions' do
      expect(no_liked_questions).to be_nil
    end
  end

  User#liked_questions

  #  User#followed_questions
  #         One-liner calling QuestionFollow method.
end

# frozen_string_literal: true

require 'questions_database'
require 'user'
#  User::find_by_name(fname, lname)
#   User#authored_questions (use Question::find_by_author_id)
#   User#authored_replies (use Reply::find_by_user_id)

describe User do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  describe '::find_by_id' do
    let(:user) { User.find_by_id(1) }
    # user =
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
end

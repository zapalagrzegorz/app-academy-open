# frozen_string_literal: true

require 'questions_database'
require 'user'
#  User::find_by_name(fname, lname)
#   User#authored_questions (use Question::find_by_author_id)
#   User#authored_replies (use Reply::find_by_user_id)

describe User do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  describe '::find_by_name' do
    let(:user) { User.find_by_name('Grzegorz', 'Zapala') }
    # user =
    let(:not_found_user) { User.find_by_name('cannot', 'find') }

    it 'generates user instance for found user ' do
      expect(user).to be_instance_of(User)
    end

    it 'returns user with first name' do
      expect(user.fname).to eq('Grzegorz')
    end

    it 'returns user with last name' do
      expect(user.lname).to eq('Zapala')
    end

    it 'returns nil when no user is found' do
      expect(not_found_user).to be_nil
    end
  end
end

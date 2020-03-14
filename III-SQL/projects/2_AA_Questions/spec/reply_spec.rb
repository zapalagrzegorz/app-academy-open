# frozen_string_literal: true

require 'questions_database'
require 'reply'
require 'user'
require 'question'

describe Reply do
  before(:example) { QuestionsDatabase.reset! }
  after(:example) { QuestionsDatabase.reset! }

  let(:reply) { Reply.find_by_id(1) }

  describe '::find_by_id' do
    let(:not_found_reply) { Reply.find_by_id(-1) }

    context 'when reply is found' do
      it 'generates reply instance' do
        expect(reply).to be_instance_of(Reply)
      end

      it 'generates reply with question_id' do
        expect(reply.question_id).to eq(1)
      end

      it 'might generate reply with parent_reply_id' do
        expect(reply.parent_reply_id).to be_nil
      end

      it 'generates reply with author_id' do
        expect(reply.author_id).to eq(2)
      end

      it 'generates reply with body' do
        expect(reply.body).to eq('Po co pytasz skoro i tak się nie zapiszesz')
      end
    end

    context 'when question is not in db' do
      it 'returns nil' do
        expect(not_found_reply).to be_nil
      end
    end
  end

  describe ':find_by_user_id' do
    let(:no_reply_user) { Reply.find_by_user_id(1) }
    let(:replies) { Reply.find_by_user_id(2) }

    context 'when some replies are found' do
      it 'generates user\'s replies' do
        expect(replies).to all be_an(Reply)
      end
    end

    context 'user has no replies' do
      it 'returns nil' do
        expect(no_reply_user).to be_nil
      end
    end
  end

  # All replies to the question at any depth.' do
  describe 'find_by_question_id(question_id)' do
    let(:replies_by_question_id) { Reply.find_by_question_id(1) }
    let(:no_reply_question) { Reply.find_by_question_id(-1) }

    context 'when some replies are found' do
      it 'generates user\'s replies' do
        expect(replies_by_question_id).to all be_an(Reply)
      end

      it 'generates predicted number of replies' do
        expect(replies_by_question_id.length).to eq(2)
      end
    end

    context 'user has no replies' do
      it 'returns nil' do
        expect(no_reply_question).to be_nil
      end
    end
  end

  describe '#author' do
    let(:author_reply) { reply.author }

    it 'returns user-author' do
      expect(author_reply).to be_an(User)
    end

    it 'returns expected author' do
      expect(author_reply.fname).to eq('Kamil')
      expect(author_reply.lname).to eq('Kisiel')
    end
  end
  # Reply#child_replies
  describe '#question' do
    let(:question) { reply.question }

    it 'returns question of the reply' do
      expect(question).to be_an(Question)
    end
  end

  describe '#parent_reply' do
    let(:parent_reply) { Reply.find_by_id(2).parent_reply }
    let(:no_parent_reply) { reply.parent_reply }

    it 'returns reply of the reply' do
      expect(parent_reply).to be_an(Reply)
    end

    it 'returns nil if there isn\'t parent reply' do
      expect(no_parent_reply).to be_nil
    end
  end

  describe '#child_replies' do
    let(:child_replies) { Reply.find_by_id(2).child_replies }
    let(:no_child_replies) { reply.child_replies }

    it 'returns child replies' do
      expect(child_replies).to all be_an(Reply)
    end

    it 'returns nil if there isn\'t parent reply' do
      expect(no_child_replies).to be_nil
    end
  end
end

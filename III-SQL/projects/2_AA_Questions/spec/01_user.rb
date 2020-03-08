# frozen_string_literal: true

require 'rspec'
require '1_remove_dups'

describe User do
  before(:each) { QuestionsDatabase.reset! }
  after(:each) { QuestionsDatabase.reset! }
  # let(:arr) { [1, 2, 3, 4, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 3, 4, 5, 4, 3, 2] }
  it 'throws error when given not array' do
    expect { my_uniq({}) }.to raise_error(ArgumentError)
  end
end

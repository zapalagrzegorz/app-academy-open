# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

feature 'creating comments' do
  # create comment of test_user user

  given!(:test_user) { FactoryBot.create(:test_user) }
  # given!(:second_user) { FactoryBot.create(:user) }

  background(:each) do
    login_as(test_user)
  end

  scenario 'should be possible for user to be commented' do
    comment_of_user = FactoryBot.create(:comment, commentable: test_user)
    visit(user_url(comment_of_user.commentable))
    expect(page).to have_content 'Comments to user'
    expect(page).to have_content(comment_of_user.content)
  end

  scenario 'should be possible to comment goal' do
    goal_comment = FactoryBot.create(:comment)
    visit(goal_url(goal_comment.commentable))
    expect(page).to have_content('Goal comments:')
    expect(page).to have_content(goal_comment.content)
  end
end

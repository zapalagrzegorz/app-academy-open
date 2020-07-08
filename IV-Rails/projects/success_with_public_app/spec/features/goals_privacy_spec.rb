# frozen_string_literal: true

require 'rails_helper'

feature 'goal privacy' do
  # You can use let! to force the method’s invocation before each example.
  # czy zanim nastąpi 'zwykły' block before? to czemu nie w before?
  # let (without !) is evaluated inside example

  given!(:test_user) { FactoryBot.create(:user) }
  given!(:second_user) { FactoryBot.create(:user) }

  describe 'public goals' do
    given!(:test_user_goal) { FactoryBot.create(:goal, user: test_user) }

    scenario 'should create public goals by default' do
      login_as(test_user)
      submit_new_goal('build a tesla coil', test_user)
      expect(page).to have_content 'Public'
    end

    scenario 'shows public goals when logged out' do
      visit user_url(test_user)
      expect(page).to have_content test_user_goal.title
    end

    scenario 'allows other users to see public goals' do
      login_as(second_user)
      visit user_url(test_user)
      expect(page).to have_content test_user_goal.title
    end
  end

  describe 'private goals' do
    given!(:private_goal) { FactoryBot.create(:goal, private: true, user: test_user) }
    # given!(:private_goal) do
    #   FactoryBot.create(:goal, user: hello_world, private: true)
    # end

    scenario 'allows creating private goals' do
      login_as(test_user)
      visit goal_url(private_goal)
      expect(page).to have_content 'Private'
    end

    scenario 'hides private goals when logged out' do
      # no login
      visit user_url(test_user)
      expect(page).not_to have_content private_goal.title
    end

    scenario 'hides private goals from other users' do
      login_as(second_user)
      visit user_url(test_user)
      expect(page).not_to have_content private_goal.title
    end
  end
end

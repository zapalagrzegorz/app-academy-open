# frozen_string_literal: true

require 'rails_helper'

feature 'goal completeness tracking' do
  given!(:test_user) { FactoryBot.create(:user) }
  # lazy loaded, not before each
  given(:foo_bar) { FactoryBot.create(:user_foo) }
  given!(:goal) { FactoryBot.create(:goal, user: test_user) }

  background(:each) do
    login_as(test_user)
  end

  describe 'goals start out uncompleted' do
    context 'on the goal show page' do
      scenario 'starts as not completed' do
        visit goal_url(goal)
        expect(page).to have_content('In progress')
      end
    end

    context "on the user's profile page" do
      scenario 'starts as not completed' do
        visit user_url(test_user)
        expect(page).to have_content('In progress')
      end
    end
  end

  describe 'marking a goal as completed' do
    context 'on the goal show page' do
      scenario 'allows user to change goal to completed' do
        visit goal_url(goal)
        # save_and_open_page
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content('Completed')
      end

      scenario 'redirects to the same page after updating goal' do
        visit goal_url(goal)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content('Goal:')
        expect(page).to have_content(goal.title)
      end

      scenario 'disallows editing completeness when it is not your goal' do
        click_button 'Logout'
        login_as(foo_bar)
        visit goal_url(goal)
        expect(page).not_to have_button('Complete')
      end
    end

    context "on the user's profile page" do
      scenario 'allows user to change goal to completed' do
        visit user_url(test_user)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content('Complete')
      end

      scenario 'redirects to the same page after updating goal' do
        visit user_url(test_user)
        # goals_text = test_user.email.to_s + 's goals'

        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content('Complete')
        # ?
        # expect(page).to have_content(goals_text.to_s)
        expect(page).to have_content(test_user.email)
        # save_and_open_page
      end

      scenario 'disallows editing completeness when it is not your goal' do
        click_button 'Logout'
        login_as(foo_bar)
        visit user_url(test_user)
        expect(page).not_to have_button('Completed')
      end
    end
  end
end

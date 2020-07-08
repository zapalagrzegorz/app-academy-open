# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

# process
feature 'creating goals' do
  before do
    test_user = create_test_user
    login_test_user
    visit new_user_goal_url(test_user)
  end

  scenario 'should have a page for creating a new goal' do
    expect(page).to have_content 'Create a new goal!'
    expect(page).to have_selector('form')
  end

  scenario 'should show the new goal after creation' do
    fill_in 'title', with: 'My new goal'
    fill_in 'details', with: 'perfect details'

    click_on 'goal-submit'
    # save_and_open_page
    expect(page).to have_content 'My new goal'
    expect(page).to have_content 'perfect details'
    expect(page).to have_content('In progress')
    expect(page).to have_content('Public')
  end
  # css cannot use :checked selector
  # scenario 'can create private goal'
end
# end

feature 'reading goals' do
  # nie chce tu sprawdzać logowania czy dodawania taksów - czyli
  # nie powtarza się co było wcześniej
  # od razu ładuj do bazy przykładowe cele i sprawdź czy sa one dla danego użytkownika
  # before do
  #   # build_test

  #   # test_user = create_test_user
  #   # login_test_user
  #   # visit new_user_goal_url(test_user)
  # end

  scenario 'should list goals' do
    test_user = create_test_user
    # build_three_goals_full(test_user)
    build_three_goals(test_user)
    visit user_url(test_user)
    expect(page).to have_content 'pickle a pepper'
    expect(page).to have_content 'get octocat\'s autograph'
    expect(page).to have_content 'bake a cake'
  end
end
# end

feature 'user can update goals' do
  # nie działa dla celów logowania
  # given(:user) { create_test_user }
  # let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

  before do
    test_user = create_test_user
    @goal = FactoryBot.create(:goal, user_id: test_user.id)
    login_test_user
    visit edit_goal_url(@goal)
    # visit new_user_goal_url(test_user)
  end

  # given(:user) { create_test_user }
  scenario 'should have a page for updating existing goal' do
    expect(page).to have_content 'Edit goal'
    expect(page).to have_selector('form')
    expect(find_field('title').value).to eq(@goal.title)
    expect(find_field('details').value).to eq(@goal.details)

    # prefilled with exisiting goal

    # są pola inputów
  end

  scenario 'should show updated goal on success' do
    fill_in 'title',	with: 'replaced title'
    fill_in 'details', with: 'replaced details'
    check('Completed?')
    check('Private?')
    click_on 'goal-submit'
    expect(page).to have_content 'replaced title'
    expect(page).to have_content 'replaced details'
    expect(page).to have_content('Completed')
    expect(page).to have_content('Private')
  end
end

feature 'deleting goals' do
  # before do

  given!(:test_user) { FactoryBot.create(:user) }

  background do
    login_test_user
  end

  scenario 'should allow to delete a goal' do
    build_three_goals(test_user)
    visit user_url(test_user)

    click_button 'Delete pickle a pepper'
    expect(page).not_to have_content 'pickle a pepper'
    expect(page).to have_content 'Goal was successfully deleted'
  end
end

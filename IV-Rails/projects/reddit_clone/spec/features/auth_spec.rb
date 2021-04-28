# frozen_string_literal: true

# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign up'
    expect(page).to have_selector('input[type="password"]')
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in 'Email', with: 'testing@email.com'
      fill_in 'Password', with: '123456'
      click_on 'Sign up'
      # expect(page).to have_current_path(user_path())
      expect(page).to have_content 'testing@email.com'
    end
  end
end

feature 'logging in' do
  # login_user
  scenario 'shows username on the homepage after login' do
    # create_test_user - operuje bezpośrednio na DB
    # przygotowuje tło
    test_user = create_test_user
    login_test_user
    expect(page).to have_current_path(user_url(test_user))
    expect(page).to have_content test_user.email
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).to have_content 'Sign in'
    expect(page).to have_selector('input[type="submit"]')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    test_user = User.create(email: 'test@user.com', password: '123456')
    login_test_user
    # save_and_open_page
    click_on 'Logout'
    expect(page).not_to have_content test_user.email
  end
end

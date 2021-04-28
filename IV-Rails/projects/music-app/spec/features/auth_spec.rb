# frozen_string_literal: true

require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Login'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Email', with: 'testing@email.com'
      fill_in 'password', with: 'biscuits'
      click_on 'Sign up'
    end

    scenario 'redirects to login page after signup' do
      expect(page).to have_content 'User was successfully created.'
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      visit new_user_url
      fill_in 'Email', with: 'testing@email.com'
      click_on 'Sign up'
    end

    scenario 're-renders the signup page after failed signup' do
      # checks for specific problem
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

# process
feature 'creating goals' do
  scenario 'should have a page for creating a new goal' do
    visit new_user_goal
    expect(page).to have_content 'Add new goal'
  end
  scenario 'should show the new goal after creation' do
    expect(page).to have 'my new goal'
    # title
    expect(page).to have_selector('input[type="checkbox"]')  
    completed
    private
    description
  end
end
# end

feature 'reading goals' do
  scenario 'should list goals'
end
# end

feature 'user can update goals' do
  scenario 'should have a page for updating existing goal'
  scenario 'should show updated goal on success'
  scenario 'should show errors goal on failure'
end

feature 'deleting goals' do
  scenario 'should allow the deletion of a goal'
end
# end

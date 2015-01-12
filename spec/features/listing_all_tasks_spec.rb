require 'spec_helper'

feature 'User can see all tasks listed' do
  before(:each) {
    Task.create(complete: false,
                description: 'create a to do app')
  }

  scenario 'when visiting the homepage' do
    visit '/tasks'
    expect(page).to have_content('create a to do app')
  end
end

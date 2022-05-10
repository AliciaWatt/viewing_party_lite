require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit '/register'
  end

  it 'shows the title of the app' do
    expect(page).to have_content('Viewing Party')
  end

  it 'can create new user' do
    fill_in 'user[name]', with: 'Greg'
    fill_in 'user[email]', with: 'greg@email.com'
    click_button('Create New User')
    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("#{user.name}'s Dashboard")
  end
  
end

require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit '/register'
  end

  it 'can create new user' do
    fill_in 'user[name]', with: 'Greg'
    fill_in 'user[email]', with: 'greg@email.com'
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "password"
    click_button('Create New User')
    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("#{user.name}'s Dashboard")
  end

  it 'shows error message when wrong info is entered' do
    User.create!(name: 'greg', email: 'greg@email.com', password: '123', password_confirmation: '123')

    fill_in 'user[name]', with: 'Greg2'
    fill_in 'user[email]', with: 'greg@email.com'
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "passwordabc"
    click_button('Create New User')

    expect(current_path).to eq('/register')
    expect(page).to have_content("Name can't be blank, Email can't be blank, and Password can't be blank")
  end
  it 'shows error if passwords do not match' do
    fill_in 'user[name]', with: 'Greg2'
    fill_in 'user[email]', with: 'greg@email.com'
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "passwordabc"

    click_button("Create New User")

    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end

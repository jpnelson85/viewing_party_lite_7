require 'rails_helper'

RSpec.describe 'User can be created', type: :feature do
  it 'creates a new user' do
    visit '/register'

    fill_in 'User name', with: 'Steve Test'
    fill_in 'Email', with: 'steve@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Create New User'

    expect(page).to have_content('Welcome, Steve Test!')
    expect(current_path).to eq(user_path(User.last))
  end

  it 'displays error message if user can not be created' do
    visit '/register'
    user = User.create!(user_name: 'Steve Test', email: 'steve@gmail.com', password: 'password')

    fill_in 'User name', with: 'Steve Practice'
    fill_in 'Email', with: 'steve@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Create New User'
save_and_open_page
    expect(page).to have_content("User can not be created. Please try again.")
    expect(current_path).to eq('/register')

    fill_in "Email", with: "bob@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create New User"

    expect(page).to have_content("User can not be created. Please try again.") 
    expect(current_path).to eq('/register')
  end
end
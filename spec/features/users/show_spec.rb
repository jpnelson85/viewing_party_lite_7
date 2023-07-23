require 'rails_helper'

RSpec.describe 'User dashboard page', type: :feature do
  before :each do
    @user1 = User.create!(user_name: "Bob", email: "bob@gmail.com", password: "password")
    @user2 = User.create!(user_name: "Sally", email: "sally@gmail.com", password: "password")
    @user3 = User.create!(user_name: "Joe", email: "joe@gmail.com", password: "password")
  end

  it 'displays user first name at the top of the page' do
    visit "/users/#{@user1.id}"

    expect(page).to have_content("#{@user1.user_name}'s Dashboard")
  end

  it 'displays a button to discover movies' do

    visit root_path

    click_on "Log In"

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_on "Login"

    visit "/users/#{@user1.id}"

    expect(page).to have_button("Discover Movies")

    click_button("Discover Movies")

    expect(current_path).to eq("/users/#{@user1.id}/discover")
  end

  it 'displays section that lists viewing parties' do
    visit "/users/#{@user1.id}"

    expect(page).to have_content("List of Viewing Parties")
  end

  it 'redirects to login page if user is not logged in' do

    visit "/users/#{@user1.id}"
save_and_open_page
    click_on "Log Out"

    visit "/users/#{@user1.id}"

    expect(page).to have_content("You must be logged or registered to access this page.")

    expect(current_path).to eq("/login")
  end
end
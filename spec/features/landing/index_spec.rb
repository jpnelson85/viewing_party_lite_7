require 'rails_helper'

RSpec.describe "landing page", type: :feature do
  before :each do
    @user1 = User.create!(user_name: "Bob", email: "bob@gmail.com", password: "password")
    @user2 = User.create!(user_name: "Sally", email: "sally@gmail.com", password: "password")
    @user3 = User.create!(user_name: "Joe", email: "joe@gmail.com", password: "password")
    visit "/"
  end

  it "displays the title of the application" do
    expect(page).to have_content("Viewing Party")
  end

  it 'displays a home link at the top that takes me to the landing page' do

    expect(page).to have_link("Home")

    click_link("Home")

    expect(current_path).to eq("/")
  end

  it 'displays button to register as a new user' do
    expect(page).to have_button("Create a New User")

    click_button("Create a New User")

    expect(current_path).to eq("/register")
  end

  it 'displays existing user email addresses' do
    user = User.create!(user_name: "Steve", email: "steve@gmail.com", password: "password")
    
    visit root_path

    click_on "Log In"

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Login"

    visit root_path

    expect(page).to have_content("#{@user1.email}")
    expect(page).to have_content("#{@user2.email}")
    expect(page).to have_content("#{@user3.email}")
  end

  it 'displays Log Out link if user is logged in' do
    user = User.create!(user_name: "Steve", email: "steve@gmail.com", password: "password")

    visit root_path
    click_on "Log In"

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Login"

    visit root_path

    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Log In")

    click_on "Log Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_link("Log In")
    expect(page).to_not have_link("Log Out")
  end

  it 'as a visitor, I can not see list of existing users' do
    visit root_path

    expect(page).to have_content("Log In")
    expect(page).to have_content("Create a New User")

    expect(page).to_not have_content("Existing Users")
  end
end
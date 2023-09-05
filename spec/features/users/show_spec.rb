require 'rails_helper'

RSpec.describe 'User dashboard page', type: :feature do
  before :each do
    @user1 = User.create!(user_name: "Bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(user_name: "Sally", email: "sally@gmail.com", password: "password", password_confirmation: "password")
    @user3 = User.create!(user_name: "Joe", email: "joe@gmail.com", password: "password", password_confirmation: "password")
  end

  it 'displays user first name at the top of the page' do
    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_on "Login"

    expect(page).to have_content("#{@user1.user_name}'s Dashboard")
  end

  it 'displays a button to discover movies' do

    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_on "Login"

    expect(page).to have_button("Discover Movies")
    expect(page).to have_content("List of Viewing Parties")
    
    click_button("Discover Movies")

    expect(current_path).to eq("/users/#{@user1.id}/discover")
  end
end
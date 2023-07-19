require "rails_helper"

RSpec.describe "User Registration form" do
  it "happy path creates a new user" do
    visit "/register"

    expect(page).to have_content("Register a New User")
    expect(page).to have_field("User name")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_field("Password confirmation")
    expect(page).to have_button("Create New User")

    fill_in "User name", with: "Steve Test"
    fill_in "Email", with: "Steve@test.com"
    fill_in :password, with: "test"
    fill_in :password_confirmation, with: "test"

    click_button "Create New User"

    expect(current_path).to eq(user_path(User.last))
  end

  it "password does not match password confirmation" do
    visit "/register"

    fill_in "User name", with: "Steve Test"
    fill_in "Email", with: "Steve@test.com"
    fill_in :password, with: "test"
    fill_in :password_confirmation, with: "Password"

    click_button "Create New User"

    expect(current_path).to eq("/register")
    expect(page).to have_content("User can not be created. Please try again.")
  end
end
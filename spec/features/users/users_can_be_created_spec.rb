require "rails_helper"

RSpec.describe "User Registration form" do
  describe "happy path" do

    it "displays a form to create a new user" do
      visit "/register"

      expect(page).to have_content("Register a New User")
      expect(page).to have_field("User name")
      expect(page).to have_field("Email")
      expect(page).to have_button("Create New User")
    end

    it "allows me to fill in the form and get redirected to the user show page that was created" do
      visit "/register"

      fill_in "User name", with: "Steve Test"
      fill_in "Email", with: "Steve@test.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"
      click_button "Create New User"

      expect(current_path).to eq(user_path(User.last))
    end

    it "creates a new user" do
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
  end

  describe "sad path" do
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

    it "displays an error message if email is already in use" do
      test_user = User.create!(user_name: "Steve", email: "test@email.com", password: "password")
      visit "/register"

      fill_in "User name", with: "Kate Test"
      fill_in "Email", with: "test@email.com"
      fill_in :password, with: "password"

      click_button "Create New User"

      expect(page).to have_content("User can not be created. Please try again.")
    end

    it "displays an error message if email is blank" do
      visit "/register"
      
      fill_in "User name", with: "Kate Test"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_button "Create New User"

      expect(page).to have_content("User can not be created. Please try again.")
    end

    it "displays error if user name is blank" do
      visit "/register"

      fill_in "Email", with: "kate@gmail.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_button "Create New User"

      expect(page).to have_content("User can not be created. Please try again.")
    end
  end
end
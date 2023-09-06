require 'rails_helper'

RSpec.describe 'Log in' do 
  describe "happy path" do
    it 'can log in with valid credentials' do
      user = User.create!(user_name: 'Steve Test', email: 'steve@gmail.com', password: 'password', password_confirmation: 'password')

      visit root_path

      expect(page).to have_link('Log In')

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in 'Email:', with: user.email
      fill_in :password, with: user.password

      click_on 'Login'

      expect(current_path).to eq(root_path)
    end

    it "displays Log Out link if user is logged in" do
      user1 = User.create!(user_name: "Steve", email: "steve@gmail.com", password: "password", password_confirmation: "password")
    
      visit login_path

      fill_in :email, with: user1.email
      fill_in :password, with: user1.password

      expect(page).to have_link("Log In")
      expect(page).to have_link("Create a New User")
      expect(page).to_not have_link("Log Out")

      click_on "Login"

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Create a New User")
    end

    it "displays landing page if user clicks log out link" do
      user1 = User.create!(user_name: "Steve", email: "steve@gmail.com", password: "password", password_confirmation: "password")
    
      visit login_path

      fill_in :email, with: user1.email
      fill_in :password, with: user1.password

      click_on "Login"

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log In")
      expect(page).to have_link("Create a New User")
      expect(page).to_not have_link("Log Out")
    end
  end

  describe "sad path" do
    it 'cannot log in with invalid credentials' do
      user1 = User.create!(user_name: "Steve", email: "Steve@email.com", password: 'password123', password_confirmation: 'password123')

      visit login_path

      fill_in :email, with: user1.email
      fill_in :password, with: "incorrect password"

      click_on "Login"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
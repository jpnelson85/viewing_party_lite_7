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

      expect(current_path).to eq(user_path(user))
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
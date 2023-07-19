require "rails_helper"

RSpec.describe "Users Movie Index Result page", type: :feature do
  describe "when I visit the user movie index result page" do
    it "displays a discover button at the top of the page", :vcr do
      user_1 = User.create!(user_name: "Steve", email: "steve@email.com", password: "password")
        visit user_movies_path(user_1)

        expect(page).to have_button("Discover Movies")
    end
  end
  describe 'top rated movies' do
    it "displays top rated movies", :vcr do
      user_1 = User.create!(user_name: "Steve", email: "steve@email.com", password: "password")
      visit "/users/#{user_1.id}/movies?q=''"
      movies = MovieFacade.new.top_rated

      movies.each do |movie|
        movie.title
        expect(page).to have_content(movie.title)
      end
    end
  end

  describe 'search movies' do
    it "displays searched movies", :vcr do
      user_1 = User.create!(user_name: "Steve", email: "steve@email.com", password: "password")
      visit "/users/#{user_1.id}/movies?search='king'"
      movies = MovieFacade.new.search("king")

      expect(movies.count).to eq(20)

      movies.each do |movie|
        movie.title
        expect(page).to have_content("King")
      end
    end
  end

  describe 'shows vote average' do
    it 'shows vote average for each movie', :vcr do
      user_1 = User.create!(user_name: "Steve", email: "steve@email.com", password: "password")
      visit "/users/#{user_1.id}/movies?q=''"
      movies = MovieFacade.new.top_rated

      expect(page).to have_content("Vote Average: #{movies.first.vote_average}")
    end
  end
end
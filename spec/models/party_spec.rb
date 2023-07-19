require 'rails_helper'

RSpec.describe Party, type: :model do
  describe "relationships" do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:movie_id) }
  end

  describe "instance methods", :vcr do
    before(:each) do
      @user1 = User.create!(user_name: "Steve", email: "Steve@email.com", password: "password")
      @user2 = User.create!(user_name: "Ben", email: "Ben@email.com", password: "password")
      @user3 = User.create!(user_name: "Jane", email: "Jane@email.com", password: "password")

      @movie = MovieFacade.new.find_movie(11)

      @party1 = Party.create!(start_time: 11, duration: 120, date: 2.days.ago, movie_id: @movie.id)

      user_parties1 = UserParty.create!(user_id: @user1.id, party_id: @party1.id)
      user_parties2 = UserParty.create!(user_id: @user2.id, party_id: @party1.id)
      user_parties3 = UserParty.create!(user_id: @user3.id, party_id: @party1.id)
    end
    describe "#attendees" do
      it "can return all attendees of party" do
        expect(@party1.attendees).to eq([@user1,@user2,@user3])
      end
    end

    describe '#movie_title' do
      it "returns the movie title" do
        expect(@party1.movie_title).to eq('Star Wars')
      end
    end

    describe '#movie_image' do
      it 'returns the movie image src' do
        expect(@party1.movie_image).to eq("https://image.tmdb.org/t/p/original/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg")
      end
    end
  end
end

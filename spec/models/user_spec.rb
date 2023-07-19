require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe "instance methods" do
    describe "#invitees" do
      it "returns all users except self" do
        user1 = User.create!(user_name: "Steve", email: "Steve@email.com", password: "password")
        user2 = User.create!(user_name: "Ben", email: "Ben@email.com", password: "password")
        user3 = User.create!(user_name: "Jane", email: "Jane@email.com", password: "password")

        expect(user1.invitees).to eq([user2, user3])
      end
    end
  end
end

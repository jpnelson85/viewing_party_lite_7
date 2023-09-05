class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }
  
  has_secure_password

  def invitees
    User.where.not(id: id)
  end
end

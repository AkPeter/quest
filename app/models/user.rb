class User < ActiveRecord::Base
  has_many :tickets

  has_secure_password

  validates :name,  presence: true
  validates :phone, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

end
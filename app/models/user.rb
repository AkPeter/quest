class User < ActiveRecord::Base
  has_many :tickets
  has_many :responses, dependent: :destroy

  has_secure_password

  validates :name,  presence: true
  validates :phone, presence: true, uniqueness: true, format: {with: /\d{10}/, message: 'only allow letters'}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

end
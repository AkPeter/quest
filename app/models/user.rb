class User < ActiveRecord::Base
  before_validation :phone_normalize

  before_destroy { |record| record.tickets.update_all(ticket_status_id:1, user_id:nil) }

  has_many :tickets
  has_many :responses, dependent: :destroy

  has_secure_password

  validates :name,  presence: true
  validates :phone, presence: true, uniqueness: true, format: {with: /\d{10}/, message: 'введите 10 цифр телефонного номера'}
  validates :email, presence: true, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: 'введите настоящий адрес электронной почты'}

  def phone_normalize
    self.phone = phone.gsub(/^\+7|[\+\s\(\)\-]/, '')
  end

  def unreserve_user_tickets
    puts 'destroyed'
    self.tickets.update_all(ticket_status_id: 1, user_id: nil) # разрезервирование всех тикетов удаляемого юзера
  end

end
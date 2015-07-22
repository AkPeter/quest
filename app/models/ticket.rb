class Ticket < ActiveRecord::Base
  belongs_to :quest_item
  belongs_to :ticket_status
  belongs_to :daytype
  belongs_to :user
end

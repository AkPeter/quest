class Response < ActiveRecord::Base
  belongs_to :quest_item
  belongs_to :user

end

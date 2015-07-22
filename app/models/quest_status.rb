class QuestStatus < ActiveRecord::Base
  has_many :quest_items
end

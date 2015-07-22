class CreateQuestStatuses < ActiveRecord::Migration
  def change
    create_table :quest_statuses do |t|
      t.string :name, :null => false
    end
  end
end

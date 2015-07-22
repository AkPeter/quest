class CreateQuestItems < ActiveRecord::Migration
  def change
    create_table :quest_items do |t|
      t.belongs_to :quest_status, index: true, :null => true, :default => 2
      t.string :name, :null => true, :default => "Название квеста"
      t.integer :session_length, :null => true, :default => 75

    end

    add_foreign_key :quest_items, :quest_statuses, name: :quest_item_quest_status_fk, on_delete: :cascade

  end
end
class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.datetime :dt, :null => false
      t.belongs_to :quest_item, index: true, :null => false
      t.belongs_to :daytype, index: true, :null => false
      t.belongs_to :ticket_status, index: true, :null => true, :default => 1
      t.belongs_to :user, index: true, :null => true
      t.integer :price, :null => true, :default => 0
      t.datetime :reserve_start_time, :null => true

      t.timestamps
    end

    add_foreign_key :tickets, :quest_items, name: :ticket_quest_item_fk, on_delete: :cascade
    add_foreign_key :tickets, :daytypes, name: :ticket_daytype_fk, on_delete: :cascade
    add_foreign_key :tickets, :ticket_statuses, name: :ticket_status_fk, on_delete: :cascade

  end

end
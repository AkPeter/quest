class CreatePricePresets < ActiveRecord::Migration
  def change
    create_table :price_presets do |t|
      t.belongs_to :quest_item, index: true, :null => false
      t.belongs_to :daytype, index: true, :null => false
      t.time :t0, :null => false, index: true
      t.time :t1, :null => false, index: true
      t.integer :price, :null => true, :default => 0
    end

    add_foreign_key :price_presets, :quest_items, name: :price_preset_quest_item_fk, on_delete: :cascade
    add_foreign_key :price_presets, :daytypes, name: :price_preset_day_type_fk, on_delete: :cascade
  end
end

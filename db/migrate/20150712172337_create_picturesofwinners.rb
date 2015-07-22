class CreatePicturesofwinners < ActiveRecord::Migration
  def change
    create_table :picturesofwinners do |t|
      t.belongs_to :quest_item, index: true, :null => false
      t.date :goaldate
      t.time :besttime
      t.string :description
      t.attachment :photourl

      t.timestamps null: false
    end

    add_foreign_key :picturesofwinners, :quest_items, name: :picturesofwinners_quest_item_fk, on_delete: :cascade
  end
end

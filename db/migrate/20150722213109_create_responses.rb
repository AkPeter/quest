class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :quest_item, index: true, :null => false
      t.belongs_to :user, index: true, :null => false
      t.string :content

      t.timestamps null: false
    end
  end
end

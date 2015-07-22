class CreateDaytypes < ActiveRecord::Migration
  def change
    create_table :daytypes do |t|
      t.string :name, :null => false
    end
  end
end

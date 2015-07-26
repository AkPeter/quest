class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :resurrection, :null => true
      t.boolean :admin, :null => true, :default => false

      t.timestamps null: false
    end
  end
end

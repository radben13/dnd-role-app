class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :race
      t.string :roleType
      t.text :description
      t.integer :level
      t.integer :experience
      t.references :player, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

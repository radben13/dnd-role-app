class AddProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.references :role, foreign_key: true, index: true
      t.string :name, null: false
    end
  end
end

class CreateAttrSets < ActiveRecord::Migration
  def change
    create_table :attr_sets do |t|
      t.integer :constitution
      t.integer :strength
      t.integer :dexterity
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.references :role, index: true, foreign_key: true
      t.timestamps null: false
    end
    
  end
end

class CreateRoleProficienciesJoinTableAndItemItemPropertiesJoinTable < ActiveRecord::Migration
  def change
    remove_index :proficiencies, column: :role_id
    remove_column :proficiencies, :role_id, :integer
    add_column :proficiencies, :slug, :string
    add_index :proficiencies, :slug, :unique => true
    
    create_join_table :proficiencies, :roles do |t|
      t.index [:proficiency_id, :role_id]
      t.index [:role_id, :proficiency_id]
    end
    
    remove_index :item_properties, column: :item_id
    remove_column :item_properties, :item_id, :integer
    add_column :item_properties, :slug, :string
    add_index :item_properties, :slug, :unique => true
    
    create_join_table :items, :item_properties do |t|
      t.index [:item_property_id, :item_id]
      t.index [:item_id, :item_property_id]
    end
  end
end

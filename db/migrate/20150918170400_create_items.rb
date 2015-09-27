class CreateItems < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name, null: false
      t.string :slug, index: true, null: false
      t.string :type
      t.integer :price_in_copper
      t.integer :weight
      t.boolean :is_weapon?
      t.boolean :is_armor?
      t.integer :dmg_dice_value
      t.integer :dmg_dice_count

      t.timestamps null: false
    end
    
    create_table :items do |t|
      t.references :role, index: true, foreign_key: true
      t.references :item_type, foreign_key: true
    end
  end
end

class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :email, index: true, null: false
      t.string :name
      t.string :permission, default: "player", null: false
      t.string :profile_img_url
      t.string :password_digest
      t.timestamps null: false
    end
    
    create_table :roles do |t|
      t.string :name, null: false
      t.string :race, null: false
      t.string :role_type
      t.text :description
      t.integer :level
      t.integer :experience
      t.integer :money_in_copper
      t.references :player, index: true, foreign_key: true
      t.timestamps null: false
    end
    
    create_table :items do |t|
      t.string :name, null: false
      t.string :slug, index: true, null: false
      t.string :type
      t.string :img_url
      t.text :modifier
      t.integer :price_in_copper
      t.integer :weight
      t.boolean :is_weapon?, index: true, null: false
      t.boolean :is_armor?, index: true, null: false
      t.integer :armor
      t.integer :dmg_dice_value
      t.integer :dmg_dice_count
      t.timestamps null: false
    end
    
    create_table :role_items do |t|
      t.references :role, index: true, foreign_key: true
      t.references :item_type, foreign_key: true
    end
    
  end
end

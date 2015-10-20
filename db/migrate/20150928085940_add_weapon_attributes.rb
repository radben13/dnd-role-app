class AddWeaponAttributes < ActiveRecord::Migration
  def change
    rename_column :items, :dmg_dice_count, :dmg_dice_count_s
    add_column :items, :dmg_dice_count_m, :integer
    rename_column :items, :dmg_dice_value, :dmg_dice_value_s
    add_column :items, :dmg_dice_value_m, :integer
    add_column :items, :dmg_type, :string
    add_column :items, :critical, :string
    add_column :items, :range, :integer
  end
end

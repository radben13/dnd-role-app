class AddLargeDamageToItems < ActiveRecord::Migration
  def change
    add_column :items, :dmg_dice_value_l, :integer
    add_column :items, :dmg_dice_count_l, :integer
  end
end

class AddSecondWeaponRangeToItems < ActiveRecord::Migration
  def change
    add_column :items, :second_weapon_range, :integer
  end
end

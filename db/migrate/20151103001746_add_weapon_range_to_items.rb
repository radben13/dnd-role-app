class AddWeaponRangeToItems < ActiveRecord::Migration
  def change
    add_column :items, :weapon_range, :integer
  end
end

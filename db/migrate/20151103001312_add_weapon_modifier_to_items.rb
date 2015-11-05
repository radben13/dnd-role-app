class AddWeaponModifierToItems < ActiveRecord::Migration
  def change
    add_column :items, :weapon_modifier, :string
  end
end

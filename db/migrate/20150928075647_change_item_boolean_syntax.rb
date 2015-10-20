class ChangeItemBooleanSyntax < ActiveRecord::Migration
  def change
    rename_column :items, :is_weapon?, :can_be_weapon
    rename_column :items, :is_armor?, :can_be_armor
  end
end

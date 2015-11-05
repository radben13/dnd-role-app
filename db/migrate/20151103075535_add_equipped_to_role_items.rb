class AddEquippedToRoleItems < ActiveRecord::Migration
  def change
    add_column :role_items, :equipped, :boolean
  end
end

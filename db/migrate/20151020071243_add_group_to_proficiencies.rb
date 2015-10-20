class AddGroupToProficiencies < ActiveRecord::Migration
  def change
    add_column :proficiencies, :group, :string
  end
end

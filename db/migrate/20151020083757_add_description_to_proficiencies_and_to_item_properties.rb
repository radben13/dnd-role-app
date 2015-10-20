class AddDescriptionToProficienciesAndToItemProperties < ActiveRecord::Migration
  def change
    add_column :proficiencies, :description, :text
    add_column :item_properties, :description, :text
  end
end

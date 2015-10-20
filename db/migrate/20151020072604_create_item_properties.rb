class CreateItemProperties < ActiveRecord::Migration
  def change
    create_table :item_properties do |t|
      t.references :item, index: true, foreign_key: true
      t.string :name
    end
  end
end

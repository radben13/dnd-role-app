class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :profile_img_url

      t.timestamps null: false
    end
  end
end

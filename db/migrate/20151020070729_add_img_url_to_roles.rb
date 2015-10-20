class AddImgUrlToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :img_url, :string
  end
end

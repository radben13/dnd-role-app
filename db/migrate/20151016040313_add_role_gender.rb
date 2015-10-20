class AddRoleGender < ActiveRecord::Migration
  def change
    add_column :roles, :gender, :string
  end
end

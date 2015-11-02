class AddHitPointsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :hit_points, :integer
  end
end

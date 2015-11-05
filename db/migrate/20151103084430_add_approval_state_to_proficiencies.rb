class AddApprovalStateToProficiencies < ActiveRecord::Migration
  def change
    add_column :proficiencies, :approval_state, :string
  end
end

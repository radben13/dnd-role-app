class RoleItem < ActiveRecord::Base
  belongs_to :role
  belongs_to :item
end
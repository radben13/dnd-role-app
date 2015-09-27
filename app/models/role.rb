class Role < ActiveRecord::Base
  belongs_to :player
  has_many :role_items
  has_many :items, through: :role_items
  validates :name, :race, :role_type, presence: true
end

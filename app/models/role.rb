class Role < ActiveRecord::Base
  belongs_to :player
  has_many :role_items, dependant: :destroy
  has_many :items, through: :role_items
  validates :name, presence: true
end

class Role < ActiveRecord::Base
  belongs_to :player
  has_many :items, dependant: :destroy
  validates :name, presence: true
end

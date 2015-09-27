class Player < ActiveRecord::Base
  has_many :roles
  validates :name, presence: true
  validates :pin, presence: true
end

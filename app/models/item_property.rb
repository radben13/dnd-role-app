class ItemProperty < ActiveRecord::Base
  has_and_belongs_to_many :items
  validates :name, :slug, :presence => true
end
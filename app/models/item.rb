class Item < ActiveRecord::Base
  has_many :role_items
  has_and_belongs_to_many :item_properties
  
  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
  
  scope :armor, -> { where(:can_be_armor => true ) }
  scope :weapon, -> { where(:can_be_weapon => true) }
  scope :non_combat, -> { where(:can_be_weapon => false, :can_be_armor => false) }
  
  def get_img_url
    if img_url
      img_url
    else
      "https://s3.amazonaws.com/radben13/assets/img/items/defaultItem.jpg"
    end
  end
  
  protected
  
  def initialize_item
    self.weight = 0 if !weight || weight < 0
    self.can_be_armor = false if !can_be_armor
    self.can_be_weapon = false if !can_be_weapon
  end
  
end

class Role < ActiveRecord::Base
  belongs_to :player
  has_one :attr_set, :dependent => :destroy
  has_and_belongs_to_many :proficiencies
  has_many :role_items
  has_many :items, through: :role_items
  validates :name, :race, :role_type, :gender, presence: true
  validate :is_valid_role_type?
  before_validation :set_role_type_string
  before_create :set_initial_values, :add_class_proficiencies, :add_racial_proficiencies
  
  def self.valid_race_list
    race_array = [
      :human, :elf, :dwarf, :half_elf, :half_orc, :gnome, :halfling
    ]
    race_array
  end
  
  def self.valid_role_type_list
    role_types_array = [
        :fighter, :wizard, :bard, :paladin, :sorcerer, :rogue, :cleric, :ranger, :warlock, :druid, :monk, :barbarian
      ]
    role_types_array
  end
  
  def get_role_img
    url_hash = {}
    Role.valid_role_type_list.each do |type|
      url_hash[type] = type.to_s + ".jpg"
    end
    if role_type == 'fighter'
      role_image_path + url_hash[role_type.to_sym]
    else
      role_image_path + url_hash[:ranger]
    end
  end
  
  def self.get_experience_list
    return [0,300,900,2700,6500,14000,23000,34000,48000,64000,85000,100000,120000,140000,165000,195000,225000,265000,305000,355000]
  end
  
  def get_proficiency_bonus
    2 + (self[:level] / 4).floor
  end
  
  def new_level?
    Role.get_experience_list[self[:level]] <= self[:experience]
  end
  
  def size_value
    if self[:race] == "gnome" || self[:race] == "halfling"
      "small"
    else
      "medium"
    end
  end
  
  def size_carrying_modifier
    if size_value == "small"
      0.5
    else
      1
    end
  end
  
  def carrying_capacity
    if !attr_set.blank?
      return (attr_set.strength * 15 * size_carrying_modifier).floor
    else
      return nil
    end
  end
  
  private
  
  def add_class_proficiencies
     
  end
  
  def add_racial_proficiencies
    
  end
  
  def is_valid_role_type?
    if role_type.blank?
      errors.add(:role_type, "cannot be left blank.")
    elsif !Role.valid_role_type_list.include? role_type.to_sym
      errors.add(:role_type, 'is not supported by this tool.')
    end
  end
  
  def set_role_type_string
    self.role_type = role_type.downcase if !role_type.blank?
  end
  
  def set_initial_values
    self.level = 1 if level.blank? || level < 1
    self.experience = Role.get_experience_list[self[:level] - 1] if experience.blank? || experience < 0
    self.money_in_copper = 0 if money_in_copper.blank? || money_in_copper < 0
    self.description = "" if description.blank?
  end
  
  def role_image_path
    "https://s3.amazonaws.com/radben13/assets/img/roles/"
  end
  
end

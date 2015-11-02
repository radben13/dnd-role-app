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
  
  def roll (dice)
    dice_count = dice[0].floor
    dice_value = dice[1]
    if dice_count < 0
      raise "Attempt to use a negative count of dice."
    end
    result = 0
    while dice_count > 0
      result += 1 + rand(dice_value)
      dice_count -= 1
    end
    result
  end
  
  def hit_die
    case self[:role_type]
    when "fighter"
      return 10
    when "ranger"
      return 10
    when "wizard"
      return 6
    when "sorcerer"
      return 6
    when "rogue"
      return 8
    when "cleric"
      return 8
    when "paladin"
      return 10
    when "bard"
      return 8
    when "barbarian"
      return 12
    when "warlock"
      return 8
    when "druid"
      return 8
    when "monk"
      return 8
    else
      raise "It is trying to use #{self[:role_type]} as a role type."
    end
  end
  
  def self.get_experience_list
    return [0,300,900,2700,6500,14000,23000,34000,48000,64000,85000,100000,120000,140000,165000,195000,225000,265000,305000,355000]
  end
  
  def get_proficiency_bonus
    2 + (self[:level] / 4).floor
  end
  
  def add_next_level
    if new_level?
      self[:level] += 1
      add_class_proficiencies
      add_racial_proficiencies
    else
      nil
    end
  end
  
  def hp
    if self[:hit_points].blank?
      set_base_hit_points
    end
    if !attr_set.blank?
      self[:hit_points] + attr_set.con_mod * level
    else
      self[:hit_points]
    end
  end
  
  def set_base_hit_points
    self[:hit_points] = hit_die
    self[:hit_points] += roll [self[:level] - 1, hit_die]
    self.save
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
  
  def self.get_race_speed (race)
    case race
    when "human"
      return 30
    when "dwarf"
      return 25
    when "elf"
      return 30
    when "half_elf"
      return 30
    when "halfling"
      return 25
    when "gnome"
      return 25
    when "half_orc"
      return 30
    else
      raise "Trying to use #{race} as a race. It is not recognized when searching for base speed."
    end
  end
  
  def speed
    speed = Role.get_race_speed self[:race]
    # once tracking equipped armor and inventory weight
    # if armor_str > attr_set.str
    #   speed -= 10
    # end
    # if inventory_weight > carrying_capacity
    #   speed 
    # end
    # encumberance and armor slowing will be calculated here
    speed
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

class AttrSet < ActiveRecord::Base
  belongs_to :role
  validates :strength, :constitution, :dexterity, :intelligence, :wisdom, :charisma, presence: true
  
  before_create :add_racial_increases
  after_create :start_role
  
  # Page 57 of BasicRules_Playerv3.4.pdf has a list of ability scores and their correlating modifiers
  def self.get_modifier(ability)
    if ability >= 30
      return 10
    elsif ability < 10
      ((ability - 11) / 2).floor
    else
      return ((ability - 10) / 2).floor
    end
  end
  
  def self.get_attribute_list
    return [:strength, :constitution, :dexterity, :intelligence, :wisdom, :charisma]
  end
  
  def str_mod
    AttrSet.get_modifier self[:strength]
  end
  
  def con_mod
    AttrSet.get_modifier self[:constitution]
  end
  
  def wis_mod
    AttrSet.get_modifier self[:wisdom]
  end
  
  def int_mod
    AttrSet.get_modifier self[:intelligence]
  end
  
  def dex_mod
    AttrSet.get_modifier self[:dexterity]
  end
  
  def cha_mod
    AttrSet.get_modifier self[:charisma]
  end
  
  def self.important_abilities (role)
    case role.role_type
    when "fighter"
      return ["strength", "constitution"]
    when "ranger"
      return ["dexterity", "wisdom"]
    when "wizard"
      return ["intelligence", "constitution"]
    when "sorcerer"
      return ["charisma", "constitution"]
    when "rogue"
      return ["dexterity", "charisma"]
    when "cleric"
      return ["wisdom", "constitution"]
    when "paladin"
      return ["strength", "charisma"]
    when "bard"
      return ["charisma", "dexterity"]
    when "barbarian"
      return ["strength", "constitution"]
    when "warlock"
      return ["charisma", "constitution"]
    when "druid"
      return ["wisdom", "constitution"]
    when "monk"
      return ["dexterity", "wisdom"]
    else
      raise "It is trying to use #{role.role_type} as a role type. Attr_Sets do not recognize this."
    end
  end
  
  def self.is_proficient_in(ability, role)
    proficiencies = saving_throw_proficiencies(role)
    proficiencies.each do |proficientAbility|
      if ability == proficientAbility.to_sym
        return true
      end
    end
    return false
  end
  
  def self.saving_throw_proficiencies (role)
    case role.role_type
    when "fighter"
      return ["strength", "constitution"]
    when "ranger"
      return ["dexterity", "strength"]
    when "wizard"
      return ["intelligence", "wisdom"]
    when "sorcerer"
      return ["charisma", "constitution"]
    when "rogue"
      return ["dexterity", "intelligence"]
    when "cleric"
      return ["wisdom", "charisma"]
    when "paladin"
      return ["wisdom", "charisma"]
    when "bard"
      return ["charisma", "dexterity"]
    when "barbarian"
      return ["strength", "constitution"]
    when "warlock"
      return ["charisma", "wisdom"]
    when "druid"
      return ["wisdom", "intelligence"]
    when "monk"
      return ["dexterity", "strength"]
    else
      raise "It is trying to use #{role.role_type} as a role type. Attr_Sets do not recognize this."
    end
  end
  
  protected
  
  def start_role
    Role.find(self[:role_id]).initiate_role
    
  end
  
  def add_racial_increases
    case self.role.race
    when "dwarf"
      self[:constitution] += 2
    when "human"
      self[:constitution] += 1
      self[:strength] += 1
      self[:wisdom] += 1
      self[:dexterity] += 1
      self[:charisma] += 1
      self[:intelligence] += 1
    when "elf"
      self[:dexterity] += 2
    when "half_elf"
      self[:charisma] += 2
      max1 = :constitution
      max2 = :wisdom
      for attribute in AttrSet.get_attribute_list
        if attribute != max1 && attribute != max2 && attribute != :charisma
          if self[attribute] >= self[max1] && self[attribute] + 1 <= 20
            if self[max2] <= self[max1]
              max2 = max1
              max1 = attribute
            else
              max1 = attribute
            end
          elsif self[attribute] >= self[max2]
            max2 = attribute
          end
        end
      end
      self[max1] += 1
      self[max2] += 1
    when "half_orc"
      self[:strength] += 2
      self[:constitution] += 1
    when "halfling"
      self[:dexterity] += 2
    when "gnome"
      self[:intelligence] += 2
    else
      raise "It is trying to use #{role.race} as a race. Attr_Sets do not recognize this."
    end
    validate_ability_scores
  end
  
  def validate_ability_scores
    for ability in AttrSet.get_attribute_list
      if self[ability] > 20
        self[ability] = 20
      end
    end
  end
  
end

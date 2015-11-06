class Proficiency < ActiveRecord::Base
  has_and_belongs_to_many :roles
  validates :name, presence: true
  
  scope :languages, -> {where(:group => "languages")}
  scope :valid_armors, -> {where(:group => "armors")}
  scope :valid_weapons, -> {where(:group => "weapons")}
  scope :abilities, -> {where(:group => "abilities")}
  scope :spells, -> {where(:group => "spells")}
  scope :skills, -> {where(:group => "skills")}
  
  scope :pending, -> {where(:approval_state => "pending")}
  scope :implementing, -> {where(:approval_state => "implementing")}
  scope :approved, -> {where(:approval_state => "approved")}
  
  def self.group_types
    ["languages", "armors", "weapons", "abilities", "spells", "skills"]
  end
  
  def requires_admin_permission
    approval_state != "pending"
  end
  
  
end
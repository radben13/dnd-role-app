class Proficiency < ActiveRecord::Base
  has_and_belongs_to_many :roles
  validates :name, :slug, presence: true
  
  scope :languages, -> {where(:group => "language")}
  scope :valid_armors, -> {where(:group => "armor")}
  scope :valid_weapons, -> {where(:group => "weapon")}
  scope :skills, -> {where(:group => "skills")}
  
end
class Player < ActiveRecord::Base
  has_secure_password
  has_many :roles
  has_many :user_sessions, dependent: :destroy
  validates :email, uniqueness: true
  validates :name, :email, presence: true
  
  before_create do
    self.profile_img_url = "https://s3.amazonaws.com/radben13/assets/img/defaultImage.jpg" if profile_img_url.blank?
    self.permission = "player" if permission.blank?
  end
  
  def is_admin?
    permission == "admin"
  end
  
  def is_dm?
    permission == "dm" || is_admin?
  end
  
end

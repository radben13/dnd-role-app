class Player < ActiveRecord::Base
  has_many :roles
  validates :name, :pin, presence: true
  
  before_create do
    self.profile_img_url = "https://s3.amazonaws.com/radben13/assets/img/defaultImage.jpg" if profile_img_url.blank?
  end
end

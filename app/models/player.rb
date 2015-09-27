class Player < ActiveRecord::Base
  has_many :roles
  validates :name, :pin, presence: true
  
  before_create do
    self.profile_img_url = "https://dl.dropboxusercontent.com/u/15921716/defaultImage.jpg" if profile_img_url.blank?
  end
end

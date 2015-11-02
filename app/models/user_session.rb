class UserSession < ActiveRecord::Base
  belongs_to :player
  validates :key, :player_id, presence: true
  
  def is_expired?
    if !logout_at.blank? || created_at < 6.hours.ago
      return true
    else
      false
    end
  end
  
end
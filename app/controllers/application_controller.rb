class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :active_session
  helper_method :current_session
  helper_method :current_player
  helper_method :has_permissions
  helper_method :has_dm_permission
  helper_method :has_admin_permission
  
  
  
  before_action :update_session_time
  
  private
  
  def current_session
    UserSession.where(:key => session[:session_id]).first
  end
  
  def current_player
    current_session.player
  end
  
  def active_session
    !current_session.blank?
  end
  
  def update_session_time
    session[:last_seen] = Time.now
  end
  
  def has_permissions
    if active_session && (current_player.id.to_s == params[:player_id] || current_player.permission == "admin")
      true
    else
      false
    end
  end
  
  def has_dm_permission
    active_session && current_player.is_dm?
  end
  
  def has_admin_permission
    active_session && current_player.is_admin?
  end
  
  def verify_session
    message = ""
    if active_session && current_session.is_expired?
      current_session.destroy
      message = "Your session has expired."
    end
    if !active_session
      session[:referrer] = url_for(params)
      if !current_session.blank?
        current_session.destroy
      end
      if message.blank?
        redirect_to "/login"
      else
        redirect_to "/login", :notice => message
      end
    end
  end
  
  def ensure_session
    passed = !session[:session_id].blank? && session[:logged_in]
    passed = passed && (session[:last_seen] > 3.hours.ago && session[:last_seen] < Time.now)
    if passed
      passed = passed && !current_session.blank? && !current_session.is_expired?
    end
    passed
  end
  
end

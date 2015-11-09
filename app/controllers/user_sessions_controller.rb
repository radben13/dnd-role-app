class UserSessionsController < ApplicationController
  before_filter :verify_session, only: :logout
  
  def new
    if active_session
      current_session.destroy
    end
    player_properties = player_params
    @player = Player.where(email: player_properties[:email].downcase).first
    if !@player.blank? && @player.authenticate(player_properties[:password])
      desired_url = session[:referrer] || "/"
      @this_session = UserSession.new
      reset_session
      @this_session.player_id = @player.id
      @this_session[:key] = session[:session_id]
      @this_session.save
      redirect_to desired_url, :status => 301, notice: "You have successfully logged in."
    else
      redirect_to :login, :status => 301, alert: "The email and password did not match any players."
    end
  end
  
  def login
    if active_session
      flash[:notice] = "You are already signed in as #{current_player.name}."
    end
  end
  
  def logout
    current_session.destroy
    reset_session
    redirect_to "/", status: 301, notice: "Successfully logged out."
  end
  
  private
  
  def player_params
    values = params.require(:player).permit(:password, :email)
    values[:email].downcase!
    values
  end
  
end
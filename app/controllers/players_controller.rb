class PlayersController < ApplicationController
  helper_method :get_player_img_url
  
  before_filter :verify_session, only: [:show, :edit, :update, :destroy]
  force_ssl only: [:new, :create, :update, :destroy]
  
  def index
    if !current_session.blank? && current_session.player.permission == "admin"
      @players = Player.all
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def new
    @player = Player.new
  end
  
  def show
    if has_permissions
      @player = Player.find(params[:player_id])
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def edit
    if has_permissions
      @player = Player.find(params[:player_id])
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def update
    if has_permissions
      @player = Player.find(params[:player_id])
      if @player.update(player_params)
        redirect_to player_path(@player)
      else
        redirect_to edit_player_path(@player)
      end
    else
      redirect_to "/", status: 401, :alert => "You do not have permission to make that action."
    end
  end
  
  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_path(@player)
    else
      redirect_to :back, alert: "There was a problem with saving the player."
    end
  end
  
  def destroy
    if has_permissions
      @player = Player.find(params[:player_id])
      name = @player.name
      @player.destroy
      redirect_to "/", status: 301, :notice => "#{name}'s account has been deleted."
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  private
  
  def get_player_img_url
    if !@player.profile_img_url.blank?
      "\"" + @player.profile_img_url + "\""
    else
      "\"https://s3.amazonaws.com/radben13/assets/img/defaultImage.jpg\""
    end
  end
  
  private
  
  def player_params
    params.require(:player).permit(:name, :profile_img_url, :email, :password, :password_confirmation)
  end
  
end
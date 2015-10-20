class PlayersController < ApplicationController
  helper_method :get_player_img_url
  helper_method :get_player_pin
  
  def index
    @players = Player.all
  end
  
  def new
    @player = Player.new
  end
  
  def show
    @player = Player.find(params[:id])
  end
  
  def edit
    @player = Player.find(params[:id])
  end
  
  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      render :show
    else
      render :edit
    end
  end
  
  def create
    @player = Player.new(player_params)
    if @player.save
      render  :show
    else
      render :new
    end
  end
  
  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path, :action => :show
  end
  
  private
  
  def get_player_pin
    if @player.pin
      @player.pin.to_s
    else
      1000.to_s
    end
  end
  
  def get_player_img_url
    if !@player.profile_img_url.blank?
      "\"" + @player.profile_img_url + "\""
    else
      "\"https://s3.amazonaws.com/radben13/assets/img/defaultImage.jpg\""
    end
  end
  
  protected
  
  def player_params
    params.require(:player).permit(:name, :profile_img_url, :pin)
  end
  
  
  
end
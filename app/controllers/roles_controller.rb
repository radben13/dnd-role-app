class RolesController < ApplicationController
  def show
    @player = Player.find(params[:player_id])
    @role = @player.roles.find(params[:id])
  end
  
  def new
    @player = Player.find(params[:player_id])
    @role = @player.roles.build
  end
  
  def edit
    @player = Player.find(params[:player_id])
    @role = @player.roles.find(params[:id])
  end
  
  def create
    @player = Player.find(params[:player_id])
    @role = @player.roles.build role_params
    if @role.save
      redirect_to player_role_path(@player, @role), :action => :show
    else
      redirect_to new_player_role_path(@player), :action => :new, :alert => "Role failed to save."
    end
  end
  
  def get_role_types
    role_types = {}
    role_types["raceList"] = Role.valid_race_list
    role_types["typeList"] = Role.valid_role_type_list
    render :json => role_types
  end
  
  def update
    @player = Player.find(params[:player_id])
    @role = @player.roles.find(params[:id])
    if @role.update(role_params)
      redirect_to player_role_path(@player, @role), :action => :show, :alert => "Role successfully edited!"
    else
      render edit_player_role_path(@player, @role)
    end
  end
  
  def destroy
    @player = Player.find(params[:player_id])
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to player_path(@player), :action => :show
  end
  
  protected
  
  def role_params
    params.require(:role).permit(:name, :race, :gender, :role_type, :description)
  end
  
end

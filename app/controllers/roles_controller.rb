class RolesController < ApplicationController
  before_filter :verify_session, except: :get_role_types
  helper_method :build_ability_score_list
  
  def show
    if has_role_permissions
      @role = current_role
      @player = @role.player
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def new
    if has_permissions
      @player = Player.find(params[:player_id])
      @role = @player.roles.build()
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def edit
    if has_role_permissions
      @role = current_role
      @player = @role.player
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def create
    if has_permissions
      @player = Player.find(params[:player_id])
      @role = @player.roles.build role_params
      if @role.save
        redirect_to role_path(@role), :action => :show, :notice => "Role successfully saved!"
      else
        redirect_to new_role_path(@player), :action => :new, :alert => "Role failed to save."
      end
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to view this page."
    end
  end
  
  def update
    if has_role_permissions
      @role = current_role
      @player = @role.player
      if @role.update(role_params)
        redirect_to role_path(@role), :action => :show, :alert => "Role successfully edited!"
      else
        redirect_to edit_role_path(@role)
      end
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to change that role."
    end
  end
  
  def get_role_types
    role_types = {}
    role_types["raceList"] = Role.valid_race_list
    role_types["typeList"] = Role.valid_role_type_list
    render :json => role_types
  end
  
  
  def destroy
    if has_role_permissions
      @role = current_role
      @player = @role.player
      @role.destroy
      redirect_to player_path(@player), :action => :show
    else
      redirect_to "/", status: 301, :alert => "You do not have permission to delete that role."
    end
  end
  
  protected
  
  def role_url_helper
    # Get the action type, then send either create_role_path or update_role_path
    ""
  end
  
  def build_ability_score_list
    results = []
    6.times do
      result = @role.roll([4,6])
      while result > 20
       result = @role.roll([4,6])
      end
      results.push(result)
    end
    results.to_json
  end
  
  def current_role
    Role.find(params[:id])
  end
  
  def has_role_permissions
    active_session && (current_player == current_role.player || current_player.permission == "admin")
  end
  
  def role_params
    params.require(:role).permit(:name, :race, :gender, :role_type, :description)
  end
  
  def edit_role_params
    params.require(:role).permit(:name, :description)
  end
end

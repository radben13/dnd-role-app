class ProficienciesController < ApplicationController
  def new
    if !has_dm_permission
      redirect_to "/", :status => 301, :alert => "You do not have permissions to view this page."
    else
      @proficiency = Proficiency.new
    end
  end
  
  def create
    if !has_dm_permission
      redirect_to "/", :status => 301, :alert => "You do not have permission to do that."
    else
      @proficiency = Proficiency.new(proficiency_params)
      @proficiency.approval_state = "pending"
      if @proficiency.save
        redirect_to proficiencies_path, :status => 301, notice: "#{@proficiency.name} has been saved!"
      else
        redirect_to new_proficiency_path, :status => 301, :alert => "There was a problem saving the proficiency."
      end
    end
  end
  
  def index
    @proficiencies = Proficiency.all
  end
  
  def show
    @proficiency = Proficiency.find(params[:id])
  end
  
  def delete
    if !has_admin_permission
      redirect_to "/", :status => 301, :alert => "You do not have permission to do that."
    else
      @proficiency = Proficiency.find(params[:id])
      name = @proficiency.name
      if !@proficiency.blank? && @proficiency.destroy
        redirect_to "/proficiencies", :status => 301, :notice => "#{name} has been deleted."
      else
        redirect_to "/proficiencies", :status => 301, :alert  => "That record could not be deleted."
      end
    end
  end
  
  def update
    @proficiency = Proficiency.find(params[:id])
    if !has_dm_permission || (@proficiency.requires_admin_permission && !has_admin_permission)
      redirect_to "/", :status => 301, :alert => "You do not have permission to do that."
    else
      if @proficiency.update(proficiency_params)
        redirect_to proficiencies_path, :status => 301, notice: "#{@proficiency.name} has been updated!"
      else
        redirect_to edit_proficiency_path(@proficiency), :status => 301, :alert => "There was a problem saving the proficiency."
      end
    end
  end
  
  protected
  
  def proficiency_params
    params.require(:proficiency).permit(:group, :description, :name)
  end
  
end
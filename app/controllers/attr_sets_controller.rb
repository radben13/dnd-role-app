class AttrSetsController < ApplicationController
  def create
    @attr_set = Role.find(params[:role_id]).build_attr_set(attr_set_params)
    if @attr_set.save
      redirect_to role_path(@attr_set.role), :status => 301, :notice => "Attributes have been saved!"
    else
      redirect_to role_path(@attr_set.role), :status => 301, :alert => "Attributes could not be saved!"
    end
  end
  
  
  private
  
  def attr_set_params
    attributes = params.require(:attr_set).permit(:constitution, :strength, :dexterity, :intelligence, :charisma, :wisdom)
    attributes.each do |key,value|
      attributes[key] = value[/\d+/].to_i
    end
    attributes
  end
  
end
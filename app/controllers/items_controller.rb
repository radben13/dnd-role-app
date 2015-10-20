class ItemsController < ApplicationController
  
  helper_method :display_weight
  helper_method :display_value
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, :action => :show
    else
      render new_item_path, :action => :new
    end
  end
  
  def update
    @item = Item.find(params[:id])
    
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, :action => :show
  end
  
  private
  
  def item_params
    if !params[:can_be_armor] && !params[:can_be_weapon]
      hash = params.require(:item).permit(:name, :slug, :img_url, :can_be_armor, :can_be_weapon, :weight, :price_in_copper, :description)
    elsif params[:can_be_armor]
      hash = params.require(:item).permit(:name, :slug, :img_url, :can_be_armor, :can_be_weapon, :weight, :price_in_copper, :description, :modifier, :armor)
    else
      hash = params.require(:item).permit(:name, :slug, :img_url, :can_be_armor, :can_be_weapon, :weight, :price_in_copper,
        :description, :modifier, :dmg_dice_count_m, :dmg_dice_value_m, :dmg_dice_count_s, :dmg_dice_value_s, :dmg_type, :critical, :range)
    end
    hash
  end
  
  def display_value
    values = {}
    result = ""
    copper = @item.price_in_copper
    values[:pp] = platinum = (copper - copper % 1000000) / 1000000
    values[:gp] = gold = (copper - platinum * 1000000 - copper % 10000) / 10000
    values[:sp]  = (copper - platinum * 1000000 - gold * 10000 - copper % 100) / 100
    values[:cp] = copper = @item.price_in_copper % 100
    values.each do |key, value|
      if value > 0
        result = result + " " + value.to_s + key.to_s
      end
    end
    result
  end
  
  def display_weight
    if @item.weight == 0
      "Nothing"
    elsif (@item.weight > 16)
      lbs = @item.weight - @item.weight % 16
      if @item.weight - lbs > 0
        lbs + "lbs " + @item.weight % 16 + "oz"
      else
        lbs + "lbs"
      end
    else
      @item.weight + "oz"
    end
  end
  
end
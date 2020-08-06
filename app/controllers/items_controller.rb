class ItemsController < ApplicationController

  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  def edit
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :item_name, :item_info, :item_price)
  end
end

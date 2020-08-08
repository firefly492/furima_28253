class ItemsController < ApplicationController
before_action :authenticate_user!, only: [:new]
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
    params.require(:item).permit(:image, :name, :info, :price)
  end
end

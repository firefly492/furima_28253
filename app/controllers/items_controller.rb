class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :item_data, only: [:show, :edit]

  def index
    @item = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price, :sales_item
    ).merge(user_id: current_user.id)
  end

  def item_data
    @item = Item.find(params[:id])
  end
end

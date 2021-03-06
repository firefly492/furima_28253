class BuyersController < ApplicationController
  before_action :current_item_user, :purchase_item

  def index
    @address = BuyerAddress.new
    @item = Item.find(params[:item_id])
  end

  def new
  end

  def create
    @address = BuyerAddress.new(address_params)
    if @address.valid?
      pay_item
      @address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def address_params
    params.require(:buyer_address).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      card: params[:token],
      amount: Item.find(params[:item_id]).price,
      currency: 'jpy'
    )
  end

  def current_item_user
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.sales_item == false && (current_user == @item.user)
  end

  def purchase_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.buyer
  end
end

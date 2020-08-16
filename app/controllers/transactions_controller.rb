class TransactionsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.valid?
      pay_item
      @transaction.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def transaction_params
    params.permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      card: params[:token],
      amount:  Item.find(params[:item_id]).price,
      currency: 'jpy'
    )
  end
end

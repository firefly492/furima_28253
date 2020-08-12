class TransactionsController < ApplicationController

  def index
    @transaction = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.save
  end

  private

  def transaction_params
    @params.require(:transaction).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number
    ).merge(item: item_id)
  end
end
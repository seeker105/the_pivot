class BidsController < ApplicationController
  include ActiveSupport::NumberHelper

  def create
    @item = Item.find(params[:item_id])
    @bid = @item.bids.new(price: bid_params[:price], user: current_user)
    if @bid.save
      flash[:success] = "Sucessfully placed bid! #{number_to_currency(@bid.price)}"
    else
      flash[:error] = @bid.errors.full_messages.join(", ")
    end
    redirect_to item_path(@item)
  end

private
  def bid_params
    params.require(:bid).permit(:price)
  end
end

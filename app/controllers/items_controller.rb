class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @bid = Bid.new
  end

  def edit
    byebug
    @item = Item.find(params[:id])
  end
end

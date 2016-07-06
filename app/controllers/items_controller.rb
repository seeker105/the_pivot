class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @bid = Bid.new
  end

  def edit
    @item = Item.find(params[:id])

    #find the business of the current user
    #find the item from that business
  end

  def update
    @item = Item.find(params[:id])
    business = @item.business
    if @item.update(item_params)
      flash[:success] = "Item ##{@item.id} successfully updated!"
      redirect_to business_dashboard_path(business.slug)
      # redirect_to item_path(item)
    else
      flash[:error] = @item.errors.full_messages.join(", ")
      render :edit
    end
  end

private
  def item_params
    params.require(:item).permit(:name, :description)
  end
end

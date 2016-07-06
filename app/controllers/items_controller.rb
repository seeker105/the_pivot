class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @bid = Bid.new
  end

  def edit
    @business = Business.find_by(slug: params[:slug])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    business = Business.find_by(slug: params[:slug])
    if @item.update(item_params)
      flash[:success] = "Item ##{@item.id} successfully updated!"
      redirect_to business_dashboard_path(business.slug)
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

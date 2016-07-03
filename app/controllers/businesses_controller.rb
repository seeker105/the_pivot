class BusinessesController < ApplicationController

  def index
    @businesses = Business.where(active: true)
  end

  def show
    @business = Business.find_by(slug: params[:slug])
    @items = @business.items
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    if @business.update(business_params)
      flash[:success] = "Successfully updated business information!"
      redirect_to @business
    else
      flash[:error] = @business.errors.full_message.join(", ")
      render :edit
    end
  end

private
  def business_params
    params.require(:business).permit(:name, :description)
  end
end

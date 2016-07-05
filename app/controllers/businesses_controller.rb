class BusinessesController < ApplicationController

  def index
    @businesses = Business.where(active: true)
  end

  def show
    @business = Business.find_by(slug: params[:slug])
    unless @business.items.empty?
      @items = @business.items
    end
  end

  def edit
    @business = Business.find_by(slug: params[:slug])
  end

  def update
    @business = Business.find_by(slug: params[:slug])
    if @business.update(business_params)
      flash[:success] = "Successfully updated business information!"
      redirect_to business_path(@business.slug)
    else
      flash[:error] = @business.errors.full_message.join(", ")
      render :edit
    end
  end

private
  def business_params
    params.require(:business).permit(:name, :description, :slug)
  end
end

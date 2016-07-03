class BusinessesController < ApplicationController

  def index
    @businesses = Business.where(active: true)
  end

  def show
    @business = Business.find_by(slug: params[:slug])
    @items = @business.items
  end
end

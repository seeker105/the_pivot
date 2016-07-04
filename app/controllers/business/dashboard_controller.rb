class Business::DashboardController < ApplicationController
  def show
    @business = Business.find_by(slug: params[:slug])
  end

end

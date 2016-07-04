class Business::DashboardController < ApplicationController
  def show
    @business = current_user.businesses.find_by(slug: params[:slug])
    if @business
      render :show
    else
      render file: "public/404"
    end
  end

end

class DashboardController < ApplicationController
  def show
    if current_user.platform_admin?
      @business = Business.find_by(slug: params[:slug])
    else
      @business = current_user.businesses.find_by(slug: params[:slug])
    end

    if @business
      render :show
    else
      render file: "public/404"
    end
  end 
end

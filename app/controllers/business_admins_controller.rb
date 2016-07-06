class BusinessAdminsController < ApplicationController
  def show
    @user = current_user
  end

  def index
    @user = current_user
    @business = current_user.businesses_owned.find_by(params[:slug])
    @admins = @business.admins
  end
end

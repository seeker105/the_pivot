class PlatformAdmin::DashboardController < PlatformAdmin::BaseController

  def show
    @businesses = Business.all
  end

  def activate
    # byebug
    Business.find_by(slug: params[:slug]).update_attribute("active", true)
    redirect_to request.referrer
  end

  def deactivate
    Business.find_by(slug: params[:slug]).update_attribute("active", false)
    redirect_to request.referrer
  end
end

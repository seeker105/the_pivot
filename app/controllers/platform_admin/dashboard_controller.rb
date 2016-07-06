class PlatformAdmin::DashboardController < PlatformAdmin::BaseController

  def show
    @active_businesses = Business.where(active: true).order(:name)
    @inactive_businesses = Business.where(active: false).order(:name)
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

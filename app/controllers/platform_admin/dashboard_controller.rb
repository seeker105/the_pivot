class PlatformAdmin::DashboardController < PlatformAdmin::BaseController

  def show
    @businesses = Business.all
  end

end

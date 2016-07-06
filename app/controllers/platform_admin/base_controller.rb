class PlatformAdmin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    return redirect_to login_path if current_user.nil?
    render file: "/public/404" unless current_user.platform_admin?
  end
end

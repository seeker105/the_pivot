class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_constants
  before_action :authorize!
  helper_method :current_user, :current_admin?, :platform_admin?

  def set_constants
    @categories = Category.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def get_favicon
    send_file Rails.root.join("app", "assets", "images", "favicon.ico"), type: "image/gif", disposition: "inline"
  end

  def platform_admin?
    current_user && current_user.platform_admin
  end

private
  def authorize!
    render file: "public/404" unless authorized?
  end

  def authorized?
    PermissionsService.new(current_user, params[:controller], params[:action], params[:slug]).allow?
  end
end

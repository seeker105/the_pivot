class SessionsController < ApplicationController
  after_action "get_login_redirect", only: [:new]

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id

      if session[:login_redirect].include?("items")
         redirect_to session[:login_redirect]
      else
         choose_login_landing_page
      end

    else
      flash.now[:error] = "Invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You are now logged out"
    redirect_to login_path
  end

  def get_login_redirect
    session[:login_redirect] = URI(request.referrer || '').path
  end

  private
  def choose_login_landing_page
    if current_user.platform_admin?
      redirect_to platform_admin_dashboard_path
    elsif current_user.admin?
      redirect_to business_admin_dashboard_path
    else current_user
      redirect_to dashboard_path
    end
  end

end

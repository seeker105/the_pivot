class BusinessAdmin::UsersController < BusinessAdmin::BaseController
  def show
    @user = current_user
    if platform_admin?
      @businesses = Business.all
    else
      @businesses = current_user.businesses
    end
  end
end

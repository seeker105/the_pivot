class BusinessAdmin::UsersController < BusinessAdmin::BaseController
  def show
    @user = current_user
    @businesses = current_user.businesses
  end
end

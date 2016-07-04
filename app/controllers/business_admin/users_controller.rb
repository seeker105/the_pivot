class BusinessAdmin::UsersController < BusinessAdmin::BaseController
  def show
    @user = current_user
  end
end

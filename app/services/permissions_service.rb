class PermissionsService

  def initialize(user, controller, action, business_id)
    @_user = user
    @_controller = controller
    @_action = action
    @_business = Business.find_by(id: business_id)
  end

  def allow?
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "items"    && action == "show"
    return true if controller == "items"    && action == "index"
    if user
      if user.platform_admin?

      elsif business && user == business.owner

      elsif business && business.admins.include?(user)

      else

      end
    end
  end

  private
  def user
    @_user
  end

  def controller
    @_controller
  end

  def action
    @_action
  end

  def business
    @_business
  end

end

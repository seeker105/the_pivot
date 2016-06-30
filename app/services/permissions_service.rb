class PermissionsService

  def initialize(user, controller, action)
    @_user = user
    @_controller = controller
    @_action = action
  end

  def allow?
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "items"   && action == "index"
    if user
      if user.platform_admin?
        return true if controller == "items"   && action == "show"

      # elsif user.store_owner? TODO add these functions
      #
      # elsif user.store_admin?

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

end

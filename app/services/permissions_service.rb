class PermissionsService

  def initialize(user, controller, action, business_slug)
    @_user = user
    @_controller = controller
    @_action = action
    @_business = Business.find_by(slug: business_slug)
  end

  def allow?
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "items"    && action == "show"
    return true if controller == "items"    && action == "index"
    return true if controller == "categories" && action == "show"
    return true if controller == "businesses" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(create new))

    if user
      return true if controller == "bids" && action.in?(%w(index create))
      return true if controller == "users" && action.in?(%w(show edit update))

      if user.platform_admin?

      elsif user.admin?
        return true if controller == "business_admin/users" && action == "show"
        if business && business.admins.include?(user)
          return true if controller == "business/dashboard" && action == "show"
          return true if controller == "businesses" && action.in?(%w(edit update))
          return true if controller == "items" && action.in?(%w(edit update))
        end

      elsif business && user == business.owner

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

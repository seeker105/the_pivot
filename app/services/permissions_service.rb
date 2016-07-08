class PermissionsService

  def initialize(user, controller, action, business_slug)
    @_user = user
    @_controller = controller
    @_action = action
    @_business = Business.find_by(slug: business_slug)
  end

  def allow?
    return true if all_users_permitted?

    if user
      return true if registered_user_permitted?
      if user.platform_admin?
        return true if platform_admin_permitted?
      elsif user.admin?
        return true if admin_permitted?
      end
    end
  end

  private
  def all_users_permitted?
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "items"    && action == "show"
    return true if controller == "items"    && action == "index"
    return true if controller == "categories" && action.in?(%w(index show))
    return true if controller == "businesses" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(create new))
    return true if controller == "application" && action == "get_favicon"
  end

  def registered_user_permitted?
    return true if controller == "bids" && action.in?(%w(index create))
    return true if controller == "users" && action.in?(%w(show edit update))
    return true if controller == "businesses" && action.in?(%w(new create))
  end

  def platform_admin_permitted?
    return true if controller == "platform_admin/dashboard" && action == "show"
    return true if controller == "platform_admin/dashboard" && action == "activate"
    return true if controller == "platform_admin/dashboard" && action == "deactivate"
    return true if controller == "business_admin/users" && action == "show"
    return true if controller == "business_dashboard" && action == "show"
    return true if controller == "businesses" && action.in?(%w(edit update))
    return true if controller == "items" && action.in?(%w(edit update))
  end

  def admin_permitted?
    return true if controller == "business_admin/users" && action == "show"
    return true if controller == "business_dashboard" && action == "show"
    return true if controller == "businesses" && action.in?(%w(edit update))
    return true if controller == "items" && action.in?(%w(edit update))
  end

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

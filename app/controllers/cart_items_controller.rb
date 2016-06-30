class CartItemsController< ApplicationController
  def index
    @cart = set_cart
  end

  def update
    item = Item.find(params[:id])
    @cart.update_quantity(item.id, params[:quantity]) if params[:quantity]
    flash[:notice] = "#{item.name}'s quantity is now updated!"
    session[:cart] = @cart.contents
    redirect_to cart_path
  end
end

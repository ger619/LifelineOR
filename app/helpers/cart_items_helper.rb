module CartItemsHelper

  def product_in_cart?(product)
    items = current_user.cart.cart_items
    items.exists?(product_id: product.id)
  end

  def cart_item(product)
    current_user.cart.cart_items.find_by(product_id: product.id)
  end
end
class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :find_product, only: :create

  def create
    @item = @cart.cart_items.new(product: @product, quantity: 1)

    respond_to do |format|
      if @item.save
        format.html { redirect_to products_path, notice: "#{@product.name} added to cart." }
      else
        format.html { redirect_to products_path, alert: "Somthing went wrong, try again." }
      end
    end
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end
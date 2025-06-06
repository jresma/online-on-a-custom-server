class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_item, only: %i[ update destroy ]

  def create
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity += 1
    item.save
    redirect_to root_path, notice: "Added #{product.name} to cart"
  end

  def update
    if @item.quantity > 1
      @item.quantity -= 1
      @item.save
    else
      @item.destroy
    end
    redirect_to root_path, notice: "Removed one #{@item.product.name} item from cart"
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: "Removed all items from cart."
  end

  private

  def set_cart
    if current_user
      @cart = Cart.find_or_create_by(user: current_user)
    else
      @cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] ||= @cart.id
    end
  end

  def set_cart_item
    @item = @cart.cart_items.find_by_product_id(params[:id])
  end
end

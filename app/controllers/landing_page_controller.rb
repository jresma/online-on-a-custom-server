class LandingPageController < ApplicationController
  before_action :set_cart

  def index
    @products = Product.all
    @cart_items = @cart.cart_items.includes(:product)
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
end

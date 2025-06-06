class LandingPageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def index
    @products = Product.all
    @cart_items = @cart.cart_items.includes(:product)
  end

  private
    def set_cart
      @cart = Cart.find_or_create_by(user: current_user)
    end
end

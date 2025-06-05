class LandingPageController < ApplicationController
  def index
    @products = Product.all
  end
end

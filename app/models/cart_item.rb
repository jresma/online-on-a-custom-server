class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    case product.code
    when 'GR1'
      green_tea
    when 'SR1'
      strawberries
    when 'CF1'
      coffee
    else
      quantity * product.price
    end
  end

  def green_tea
    # For every 2 items, 1 is free
    paid_items = (quantity / 2.0).ceil
    paid_items * product.price
  end

  def strawberries
    # For every 3 or more items, price @4.5
    quantity >= 3 ? quantity * 4.5 : quantity * product.price
  end

  def coffee
    # For every 3 or more items, price @2/3 of the original
    discount = product.price * (2.0 / 3)
    quantity >= 3 ? quantity * discount : quantity * product.price
  end
end

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    case product.code
    when "GR1"
      bogo
    when "SR1"
      bulk_discount
    when "CF1"
      bulk_discount_rate
    else
      orig_price
    end
  end

  def bogo
    # For every 2 items, 1 is free
    paid_items = (quantity / 2.0).ceil
    paid_items * product.price
  end

  def bulk_discount
    # For every 3 or more items, price @4.5
    (quantity >= 3 ? quantity * 4.5 : orig_price).ceil(2)
  end

  def bulk_discount_rate
    # For every 3 or more items, price @2/3 of the original
    discount = product.price * (2.0 / 3)
    (quantity >= 3 ? quantity * discount : orig_price).ceil(2)
  end

  private

    def orig_price
      quantity * product.price
    end
end

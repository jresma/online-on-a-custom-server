require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:user) { User.create!(email: "email@sample.com", password: "123456") }
  let(:cart) { Cart.create!(user: user) }

  describe "associations" do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  before do
    user
    cart
  end

  describe "#bogo" do
    let(:product) { create(:product) }

    it "calculates total price without discount" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 1)
      expect(cart_item.total_price).to eq(3.11)
    end

    it "calculates total price with buy one get one" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 4)
      expect(cart_item.total_price).to eq(6.22)
    end
  end

  describe "#bulk_discount" do
    let(:product) { create(:product, :strawberries) }

    it "calculates total price without discount" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 2)
      expect(cart_item.total_price).to eq(10)
    end

    it "calculates total price with bulk discount" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 3)
      expect(cart_item.total_price).to eq(13.5)
    end
  end

  describe "#bulk_discount_rate" do
    let(:product) { create(:product, :coffee) }

    it "calculates total price without discount" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 1)
      expect(cart_item.total_price).to eq(11.23)
    end

    it "calculates total price with discount rate" do
      cart_item = CartItem.new(product: product, cart: cart, quantity: 3)
      expect(cart_item.total_price).to eq(22.46)
    end
  end
end

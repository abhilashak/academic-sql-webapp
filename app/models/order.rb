# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validate :check_product_available_in_stock

  private

  def check_product_available_in_stock
    return if product.stock_quantity > 0

    errors.add(:product, "is out of stock")
  end
end

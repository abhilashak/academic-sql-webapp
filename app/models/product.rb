class Product < ApplicationRecord
  has_many :orders

  validates_presence_of :title, :price, :category, :stock_quantity
  validates :price, numericality: { greater_than: 0 }
  validates :category, inclusion: { in: %w[women men kids infants] }

  # Don't duplicate precision validation if DB handles it
  # The DECIMAL(10,2) constraint is sufficient at DB level
end

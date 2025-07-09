# db/seeds/orders_seeder.rb
class OrdersSeeder < BaseSeeder
  ORDERS_COUNT = 5_000

  class << self
    def create_orders(users, products)
      puts "🛒 Creating #{ORDERS_COUNT} orders..."

      # Only use products that are active AND have stock
      available_products = products.select { |p| p.active && p.stock_quantity > 0 }

      if available_products.empty?
        puts "❌ No products with stock available! Skipping order creation."
        return []
      end

      orders = []
      ORDERS_COUNT.times do |i|
        order = Order.create!(order_attributes(users, available_products))
        orders << order
        UiHelpers.progress_indicator(i, ORDERS_COUNT, 100)
      end

      puts "\n✅ Created #{orders.count} orders"
      orders
    end

    private

    def order_attributes(users, available_products)
      {
        user: users.sample,
        product: available_products.sample
      }
    end
  end
end

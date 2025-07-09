# db/seeds/products_seeder.rb
class ProductsSeeder < BaseSeeder
  PRODUCTS_COUNT = 1_000

  PRODUCT_TYPES = [
    "T-Shirt", "Jeans", "Sneakers", "Dress", "Jacket", "Sweater",
    "Shorts", "Boots", "Blouse", "Pants", "Sandals", "Hoodie",
    "Skirt", "Coat", "Socks", "Hat", "Scarf", "Gloves",
    "Belt", "Bag", "Watch", "Sunglasses", "Jewelry", "Perfume"
  ].freeze

  ADJECTIVES = [
    "Premium", "Classic", "Modern", "Vintage", "Luxury", "Comfortable",
    "Stylish", "Trendy", "Elegant", "Casual", "Sport", "Designer"
  ].freeze

  class << self
    def create_products
      puts "🛍️ Creating #{PRODUCTS_COUNT} products..."

      products = []
      PRODUCTS_COUNT.times do |i|
        product = Product.create!(product_attributes(i))
        products << product
        UiHelpers.progress_indicator(i, PRODUCTS_COUNT, 100)
      end

      puts "\n✅ Created #{products.count} products"
      products
    end

    private

    def product_attributes(index)
      product_type = PRODUCT_TYPES.sample
      adjective = ADJECTIVES.sample
      category = random_category

      {
        title: "#{adjective} #{product_type} ##{index + 1}",
        description: generate_description(adjective, product_type, category),
        price: random_price,
        category: category,
        stock_quantity: random_stock,
        active: [ true, true, true, false ].sample # 75% active
      }
    end

    def generate_description(adjective, product_type, category)
      "#{adjective} #{product_type.downcase} perfect for #{category} category. " \
      "Made with premium materials and excellent craftsmanship. " \
      "Features modern design and superior comfort for everyday wear."
    end

    def random_category
      [ 'men', 'women', 'kids', 'infants' ].sample
    end

    def random_price
      [ 9.99, 19.99, 29.99, 49.99, 99.99, 199.99, 299.99, 499.99 ].sample
    end

    def random_stock
      [ 0, 5, 10, 25, 50, 100, 500 ].sample
    end
  end
end

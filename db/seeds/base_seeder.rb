# db/seeds/base_seeder.rb
require_relative 'helpers/ui_helpers'

class BaseSeeder
  class << self
    def seed_all
      puts "🌱 Starting modular seed data creation..."

      clear_existing_data if should_clear_data?

      # Order matters due to foreign key dependencies
      users = UsersSeeder.create_users
      products = ProductsSeeder.create_products
      courses = CoursesSeeder.create_courses
      schools = SchoolsSeeder.create_schools
      OrdersSeeder.create_orders(users, products)
      StudentsSeeder.create_students(users, courses, schools)

      UiHelpers.print_summary_box("MODULAR SEED DATA CREATION COMPLETE!", summary_data)
      UiHelpers.print_verification_stats(verification_stats)
    end

    private

    def should_clear_data?
      ENV['CLEAR_DATA'] == 'true' || Rails.env.development?
    end

    def clear_existing_data
      puts "🗑️  Clearing existing data..."
      Student.destroy_all
      Order.destroy_all
      User.destroy_all
      Product.destroy_all
      Course.destroy_all
      School.destroy_all
    end

    def summary_data
      {
        "👥 Users": User.count,
        "🛍️ Products": Product.count,
        "📚 Courses": Course.count,
        "🏫 Schools": School.count,
        "🛒 Orders": Order.count,
        "🎓 Students": Student.count
      }
    end

    def verification_stats
      {
        "Users with orders": User.joins(:orders).distinct.count.to_s,
        "Products with orders": Product.joins(:orders).distinct.count.to_s,
        "Active products": Product.where(active: true).count.to_s,
        "Students per school (avg)": (Student.count.to_f / School.count).round(1).to_s,
        "Students per course (avg)": (Student.count.to_f / Course.count).round(1).to_s
      }
    end
  end
end

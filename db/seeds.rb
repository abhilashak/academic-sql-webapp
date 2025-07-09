# ==============================================================================
# SEED DATA CONFIGURATION - Modify these constants to control record counts
# ==============================================================================

# Record counts - easily adjustable
USERS_COUNT = 10_000
PRODUCTS_COUNT = 1000
COURSES_COUNT = 50
SCHOOLS_COUNT = 25
ORDERS_COUNT = 5_000
STUDENTS_COUNT = 5_000  # Must be <= USERS_COUNT due to unique constraint

# ==============================================================================
# HELPER METHODS
# ==============================================================================

def random_gender
  [ 'male', 'female', 'not-specified' ].sample
end

def random_category
  [ 'men', 'women', 'kids', 'infants' ].sample
end

def random_date_of_birth
  Date.today - rand(18..80).years - rand(365).days
end

def random_phone
  "+1#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
end

def random_price
  [ 9.99, 19.99, 29.99, 49.99, 99.99, 199.99, 299.99, 499.99 ].sample
end

def random_stock
  [ 0, 5, 10, 25, 50, 100, 500 ].sample
end

def random_past_date(days_ago_max = 365)
  Date.today - rand(1..days_ago_max).days
end

# ==============================================================================
# CLEAR EXISTING DATA (optional - uncomment if needed)
# ==============================================================================

puts "Clearing existing data..."
Student.destroy_all
Order.destroy_all
User.destroy_all
Product.destroy_all
Course.destroy_all
School.destroy_all

puts "🌱 Starting seed data creation..."

# ==============================================================================
# 1. USERS - No dependencies
# ==============================================================================

puts "👥 Creating #{USERS_COUNT} users..."

users = []
USERS_COUNT.times do |i|
  first_name = [ "John", "Jane", "Michael", "Sarah", "David", "Emily", "Robert", "Lisa", "William", "Ashley" ].sample
  last_name = [ "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez" ].sample
  middle_name = [ "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", nil ].sample

  user = User.create!(
    first_name: first_name,
    middle_name: middle_name,
    last_name: last_name,
    email: "user#{i+1}@example.com",
    phone_number: random_phone,
    gender: random_gender,
    date_of_birth: random_date_of_birth
  )
  users << user

  print "." if (i + 1) % 1000 == 0
end
puts "\n✅ Created #{users.count} users"

# ==============================================================================
# 2. PRODUCTS - No dependencies
# ==============================================================================

puts "🛍️ Creating #{PRODUCTS_COUNT} products..."

product_titles = [
  "T-Shirt", "Jeans", "Sneakers", "Dress", "Jacket", "Sweater", "Shorts", "Boots",
  "Blouse", "Pants", "Sandals", "Hoodie", "Skirt", "Coat", "Socks", "Hat",
  "Scarf", "Gloves", "Belt", "Bag", "Watch", "Sunglasses", "Jewelry", "Perfume"
]

products = []
PRODUCTS_COUNT.times do |i|
  title = "#{product_titles.sample} ##{i+1}"
  category = random_category

  product = Product.create!(
    title: title,
    description: "High quality #{title.downcase} perfect for #{category} category. Made with premium materials and excellent craftsmanship.",
    price: random_price,
    category: category,
    stock_quantity: random_stock,
    active: [ true, true, true, false ].sample # 75% active
  )
  products << product

  print "." if (i + 1) % 100 == 0
end
puts "\n✅ Created #{products.count} products"

# ==============================================================================
# 3. COURSES - No dependencies
# ==============================================================================

puts "📚 Creating #{COURSES_COUNT} courses..."

course_subjects = [
  "Mathematics", "Physics", "Chemistry", "Biology", "Computer Science",
  "English Literature", "History", "Geography", "Art", "Music",
  "Psychology", "Philosophy", "Economics", "Business", "Engineering"
]

course_levels = [ "Beginner", "Intermediate", "Advanced", "Expert" ]

courses = []
COURSES_COUNT.times do |i|
  subject = course_subjects.sample
  level = course_levels.sample

  course = Course.create!(
    title: "#{level} #{subject}",
    description: "Comprehensive #{level.downcase} course in #{subject}. Learn fundamental concepts and practical applications."
  )
  courses << course

  print "." if (i + 1) % 10 == 0
end
puts "\n✅ Created #{courses.count} courses"

# ==============================================================================
# 4. SCHOOLS - No dependencies
# ==============================================================================

puts "🏫 Creating #{SCHOOLS_COUNT} schools..."

school_names = [
  "Central High School", "Riverside Academy", "Oakwood Institute", "Maple Valley School",
  "Pine Ridge University", "Sunset College", "Mountain View Academy", "Lakeside Institute",
  "Greenfield School", "Harbor Bay Academy", "Hillcrest College", "Valley Springs School"
]

schools = []
SCHOOLS_COUNT.times do |i|
  school = School.create!(
    title: "#{school_names.sample} #{i+1}"
  )
  schools << school
end
puts "✅ Created #{schools.count} schools"

# ==============================================================================
# 5. ORDERS - Depends on users and products
# ==============================================================================

puts "🛒 Creating #{ORDERS_COUNT} orders..."

# Only use products that are active AND have stock
available_products = products.select { |p| p.active && p.stock_quantity > 0 }

if available_products.empty?
  puts "❌ No products with stock available! Skipping order creation."
  orders = []
else
  orders = []

  ORDERS_COUNT.times do |i|
    order = Order.create!(
      user: users.sample,
      product: available_products.sample
    )
    orders << order

    print "." if (i + 1) % 5000 == 0
  end
  puts "\n✅ Created #{orders.count} orders"
end

# ==============================================================================
# 6. STUDENTS - Depends on users, courses, schools (unique user_id constraint)
# ==============================================================================

puts "🎓 Creating #{STUDENTS_COUNT} students..."

# Ensure we don't exceed user count due to unique constraint
actual_students_count = [ STUDENTS_COUNT, users.count ].min
selected_users = users.sample(actual_students_count)

students = []
selected_users.each_with_index do |user, i|
  student = Student.create!(
    user: user,
    course: courses.sample,
    school: schools.sample,
    enrolment_date: random_past_date(730) # Within last 2 years
  )
  students << student

  print "." if (i + 1) % 500 == 0
end
puts "\n✅ Created #{students.count} students"

# ==============================================================================
# SUMMARY
# ==============================================================================

puts "\n" + "="*60
puts "SEED DATA CREATION COMPLETE!"
puts "="*60
puts "Summary:"
puts "   👥 Users:     #{User.count}"
puts "   🛍️  Products:  #{Product.count}"
puts "   📚 Courses:   #{Course.count}"
puts "   🏫 Schools:   #{School.count}"
puts "   🛒 Orders:    #{Order.count}"
puts "   🎓 Students:  #{Student.count}"
puts "="*60

# ==============================================================================
# VERIFICATION QUERIES (optional)
# ==============================================================================

puts "\n Verification:"
puts "   • Users with orders: #{User.joins(:orders).distinct.count}"
puts "   • Products with orders: #{Product.joins(:orders).distinct.count}"
puts "   • Active products: #{Product.where(active: true).count}"
puts "   • Students per school (avg): #{(Student.count.to_f / School.count).round(1)}"
puts "   • Students per course (avg): #{(Student.count.to_f / Course.count).round(1)}"

puts "\n Seed data ready for use!"

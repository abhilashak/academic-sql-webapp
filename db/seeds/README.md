# Modular Seed System Documentation

This directory contains a modular seed data system that separates concerns and makes seed data generation more maintainable.

## 📁 Structure

```
db/seeds/
├── README.md           # This documentation
├── base_seeder.rb      # Orchestrator and helper module access
├── helpers/
│   ├── data_generators.rb # Random data generation methods
│   └── ui_helpers.rb      # Console output and progress indicators
├── users_seeder.rb     # User creation logic & config
├── products_seeder.rb  # Product creation logic & config
├── courses_seeder.rb   # Course creation logic & config
├── schools_seeder.rb   # School creation logic & config
├── orders_seeder.rb    # Order creation logic & config
└── students_seeder.rb  # Student creation logic & config
```

## 🎛️ Configuration

Configuration for the number of records to create is now located at the top of each **individual seeder file**.

**Example:** Edit `db/seeds/users_seeder.rb`:
```ruby
class UsersSeeder < BaseSeeder
  USERS_COUNT = 10_000 # Number of users to create
  # ...
end
```
Similarly, `PRODUCTS_COUNT` is in `products_seeder.rb`, `COURSES_COUNT` is in `courses_seeder.rb`, and so on.

## 🚀 Usage

### Basic Usage
```bash
rails db:seed
```

### Clear existing data first
```bash
CLEAR_DATA=true rails db:seed
```

### Environment-specific seeding
```bash
# Development (clears data automatically)
RAILS_ENV=development rails db:seed

# Production (preserves existing data)
RAILS_ENV=production rails db:seed
```

## 🏗️ Architecture

### Dependency Order
1. **Independent Models**: Users, Products, Courses, Schools
2. **Dependent Models**: Orders (needs Users + Products), Students (needs Users + Courses + Schools)

### Base Seeder Features
- **Helper access**: Provides access to `DataGenerators` and `UiHelpers`.
- **Environment detection**: Auto-clear in development.
- **Dependency orchestration**: Calls individual seeders in the correct order.
- **Comprehensive reporting**: Gathers and displays summary/verification data.

### Individual Seeders
Each seeder is responsible for:
- **Configuration**: Defines its own `..._COUNT` constant.
- **Data generation**: Contains model-specific attributes and logic.
- **Progress tracking**: Uses `UiHelpers` for feedback.
- **Dependency management**: Accepts required parent records.

## 🔧 Customization

### Adding New Models
1.  Create `new_model_seeder.rb` inheriting from `BaseSeeder`.
2.  Add a `NEW_MODEL_COUNT` constant at the top of your new seeder file.
3.  Add the call to your new seeder in the `seed_all` method of `db/seeds/base_seeder.rb`.
4.  `require` your new seeder file in the main `db/seeds.rb`.

### Modifying Data Generation
- **Constants**: Edit data arrays (e.g., `FIRST_NAMES`) in individual seeders.
- **Attributes**: Modify `*_attributes` methods in individual seeders.
- **Random Data**: Add new methods to `db/seeds/helpers/data_generators.rb`.

### Example: Custom Product Categories
```ruby
# In products_seeder.rb
PRODUCT_TYPES = ['electronics', 'books', 'clothing'].freeze

def product_attributes(index)
  # ... existing attributes ...
  {
    title: "#{PRODUCT_TYPES.sample} ##{index + 1}"
    #...
  }
end
```

## 📊 Features

### Smart Constraints Handling
- **Stock validation**: Only creates orders for available products.
- **Unique constraints**: Respects `user_id` uniqueness in students.
- **Foreign keys**: Maintains referential integrity.

### Realistic Data
- **Names**: Diverse first/last name combinations.
- **Emails**: Sequential unique addresses.
- **Prices**: Realistic price points for products.
- **Dates**: Age-appropriate birth dates and enrollment dates.

### Performance Optimizations
- **Batch processing**: Efficient record creation.
- **Progress indicators**: Visual feedback for long operations.
- **Memory management**: No excessive object accumulation.

## 🧪 Testing

```ruby
# Test individual seeders
users = UsersSeeder.create_users
products = ProductsSeeder.create_products

# Test with custom counts by temporarily changing the constant
# in the respective seeder file.
# For example, in users_seeder.rb:
# USERS_COUNT = 5
```

## 📈 Scaling

For large datasets:
1.  Increase the `..._COUNT` constants in the relevant seeder files.
2.  Consider database-specific optimizations (e.g., `activerecord-import` gem).
3.  Use background jobs for very large datasets if seeding becomes too slow.
4.  Monitor memory usage and add batching if needed.

## 🔍 Verification

The system automatically provides:
- Record counts for each model.
- Relationship verification (users with orders, etc.).
- Data quality checks (active products, average distributions).

## 🚨 Troubleshooting

### Common Issues
- **Foreign key errors**: Check dependency order in `base_seeder.rb`.
- **Validation errors**: Review model validations and seed data generation logic.
- **Memory issues**: Reduce batch sizes or add manual garbage collection calls.
- **Unique constraint violations**: Ensure proper user sampling for students.

### Debug Mode
Add `puts` statements to individual seeders:
```ruby
def create_users
  puts "DEBUG: Creating #{USERS_COUNT} users..."
  # ... creation logic ...
end
``` 
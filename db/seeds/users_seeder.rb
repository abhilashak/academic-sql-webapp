# db/seeds/users_seeder.rb
class UsersSeeder < BaseSeeder
  USERS_COUNT = 10_000

  FIRST_NAMES = [
    "John", "Jane", "Michael", "Sarah", "David", "Emily",
    "Robert", "Lisa", "William", "Ashley", "James", "Jessica",
    "Christopher", "Amanda", "Daniel", "Stephanie", "Matthew", "Jennifer"
  ].freeze

  LAST_NAMES = [
    "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia",
    "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez",
    "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore"
  ].freeze

  MIDDLE_INITIALS = [ "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", nil ].freeze

  class << self
    def create_users
      puts "👥 Creating #{USERS_COUNT} users..."

      users = []
      USERS_COUNT.times do |i|
        user = User.create!(user_attributes(i))
        users << user
        UiHelpers.progress_indicator(i, USERS_COUNT, 1000)
      end

      puts "\n✅ Created #{users.count} users"
      users
    end

    private

    def user_attributes(index)
      {
        first_name: FIRST_NAMES.sample,
        middle_name: MIDDLE_INITIALS.sample,
        last_name: LAST_NAMES.sample,
        email: random_email(index + 1),
        phone_number: random_phone,
        gender: random_gender,
        date_of_birth: random_date_of_birth
      }
    end

    def random_date_of_birth
      Date.today - rand(18..80).years - rand(365).days
    end

    def random_phone
      "+1#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
    end

    def random_gender
      [ 'male', 'female', 'not-specified' ].sample
    end

    def random_email(prefix = "user", index = nil)
      if index
        "#{prefix}#{index}@example.com"
      else
        "#{prefix}#{rand(1000..9999)}@example.com"
      end
    end
  end
end

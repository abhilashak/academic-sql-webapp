# db/seeds/students_seeder.rb
class StudentsSeeder < BaseSeeder
  STUDENTS_COUNT = 5_000  # Must be <= UsersSeeder::USERS_COUNT due to unique constraint

  class << self
    def create_students(users, courses, schools)
      puts "🎓 Creating #{STUDENTS_COUNT} students..."

      # Ensure we don't exceed user count due to unique constraint
      actual_students_count = [ STUDENTS_COUNT, users.count ].min
      selected_users = users.sample(actual_students_count)

      students = []
      selected_users.each_with_index do |user, i|
        student = Student.create!(student_attributes(user, courses, schools))
        students << student
        UiHelpers.progress_indicator(i, actual_students_count, 100)
      end

      puts "\n✅ Created #{students.count} students"
      students
    end

    private

    def student_attributes(user, courses, schools)
      {
        user: user,
        course: courses.sample,
        school: schools.sample,
        enrolment_date: random_past_date(730) # Within last 2 years
      }
    end

    def random_past_date(days_ago_max = 365)
      Date.today - rand(1..days_ago_max).days
    end
  end
end

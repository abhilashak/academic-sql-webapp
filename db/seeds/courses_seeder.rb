# db/seeds/courses_seeder.rb
class CoursesSeeder < BaseSeeder
  COURSES_COUNT = 50

  SUBJECTS = [
    "Mathematics", "Physics", "Chemistry", "Biology", "Computer Science",
    "English Literature", "History", "Geography", "Art", "Music",
    "Psychology", "Philosophy", "Economics", "Business", "Engineering",
    "Statistics", "Data Science", "Web Development", "Machine Learning", "Design"
  ].freeze

  LEVELS = [ "Beginner", "Intermediate", "Advanced", "Expert" ].freeze

  COURSE_TYPES = [ "Course", "Workshop", "Bootcamp", "Seminar", "Masterclass" ].freeze

  class << self
    def create_courses
      puts "📚 Creating #{COURSES_COUNT} courses..."

      courses = []
      COURSES_COUNT.times do |i|
        course = Course.create!(course_attributes(i))
        courses << course
        UiHelpers.progress_indicator(i, COURSES_COUNT, 10)
      end

      puts "\n✅ Created #{courses.count} courses"
      courses
    end

    private

    def course_attributes(index)
      subject = SUBJECTS.sample
      level = LEVELS.sample
      course_type = COURSE_TYPES.sample

      {
        title: "#{level} #{subject} #{course_type}",
        description: generate_description(level, subject, course_type)
      }
    end

    def generate_description(level, subject, course_type)
      "Comprehensive #{level.downcase} #{course_type.downcase} in #{subject}. " \
      "Learn fundamental concepts, practical applications, and real-world skills. " \
      "Perfect for students looking to master #{subject.downcase} from #{level.downcase} level."
    end
  end
end

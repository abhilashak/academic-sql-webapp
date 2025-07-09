# db/seeds/schools_seeder.rb
class SchoolsSeeder < BaseSeeder
  SCHOOLS_COUNT = 25

  SCHOOL_NAMES = [
    "Central High School", "Riverside Academy", "Oakwood Institute",
    "Maple Valley School", "Pine Ridge University", "Sunset College",
    "Mountain View Academy", "Lakeside Institute", "Greenfield School",
    "Harbor Bay Academy", "Hillcrest College", "Valley Springs School",
    "Northpoint University", "Southgate Academy", "Eastwood Institute",
    "Westfield College", "Metro Tech", "Urban Academy"
  ].freeze

  SCHOOL_TYPES = [
    "University", "College", "Academy", "Institute", "School",
    "Campus", "Center", "Foundation"
  ].freeze

  class << self
    def create_schools
      puts "🏫 Creating #{SCHOOLS_COUNT} schools..."

      schools = []
      SCHOOLS_COUNT.times do |i|
        school = School.create!(school_attributes(i))
        schools << school
        UiHelpers.progress_indicator(i, SCHOOLS_COUNT, 5)
      end

      puts "✅ Created #{schools.count} schools"
      schools
    end

    private

    def school_attributes(index)
      if index < SCHOOL_NAMES.length
        # Use predefined names first
        title = SCHOOL_NAMES[index]
      else
        # Generate new names if we need more schools
        base_name = [ "North", "South", "East", "West", "Central", "Metro" ].sample
        location = [ "Ridge", "Valley", "Heights", "Park", "Grove", "Hills" ].sample
        school_type = SCHOOL_TYPES.sample
        title = "#{base_name} #{location} #{school_type}"
      end

      { title: title }
    end
  end
end

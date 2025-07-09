# app/models/course.rb
class Course < ApplicationRecord
  has_many :students

  validates :title, presence: true
end

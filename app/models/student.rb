# app/models/student.rb
class Student < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :school

  validates :enrolment_date, presence: true
end

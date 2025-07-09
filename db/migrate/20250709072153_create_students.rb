class CreateStudents < ActiveRecord::Migration[8.0]
  # create students table
  def up
    execute <<~SQL
      CREATE TABLE students (
        id BIGSERIAL PRIMARY KEY,
        user_id BIGINT NOT NULL,
        course_id BIGINT NOT NULL,
        school_id BIGINT NOT NULL,
        enrolment_date DATE NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

        -- add unique constraints on user_id (one student per user)
        CONSTRAINT unique_students_user_id UNIQUE (user_id),

        -- Foreign key constraints
        CONSTRAINT fk_students_user_id
          FOREIGN KEY (user_id) REFERENCES users(id)
          ON DELETE CASCADE ON UPDATE CASCADE,

        CONSTRAINT fk_students_course_id
          FOREIGN KEY (course_id) REFERENCES courses(id),

        CONSTRAINT fk_students_school_id
          FOREIGN KEY (school_id) REFERENCES schools(id)
          ON DELETE CASCADE ON UPDATE CASCADE
      );

      -- indexes for performance
      CREATE INDEX idx_students_course_id ON students(course_id);
      CREATE INDEX idx_students_school_id ON students(school_id);
      -- Note: user_id index is automatically created by UNIQUE constraint
    SQL
  end

  # drop students table
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS students;
    SQL
  end
end

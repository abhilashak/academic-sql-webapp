class CreateCourses < ActiveRecord::Migration[8.0]
  # create courses table
  def up
    execute <<~SQL
      CREATE TABLE courses (
        id BIGSERIAL PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        description TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    SQL
  end

  # drop table courses
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS courses;
    SQL
  end
end

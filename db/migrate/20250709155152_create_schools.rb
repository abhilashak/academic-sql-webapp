class CreateSchools < ActiveRecord::Migration[8.0]
  # create table schools
  def up
    execute <<~SQL
      CREATE TABLE schools (
        id BIGSERIAL PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    SQL
  end

  # drop table schools
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS schools;
    SQL
  end
end

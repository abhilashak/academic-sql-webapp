class UpdateUsersSplitNameGenderBirthDate < ActiveRecord::Migration[8.0]
  # update users remove name add firstname, lastname and middlename
  # add gender, date of birth
  def up
    execute <<~SQL
      CREATE TYPE gender_enum AS ENUM('male', 'famale', 'not-specified');

      ALTER TABLE users DROP COLUMN name;
      ALTER TABLE users ADD COLUMN first_name VARCHAR(100) NOT NULL;
      ALTER TABLE users ADD COLUMN middle_name VARCHAR(100);
      ALTER TABLE users ADD COLUMN last_name VARCHAR(100) NOT NULL;

      ALTER TABLE users ADD COLUMN gender gender_enum;
      ALTER TABLE users ADD COLUMN date_of_birth DATE;
    SQL
  end

  # putback column: name, remove columns: first_name, last_name, middle_name
  # gender, date_of_birth
  def down
    execute <<~SQL
      ALTER TABLE users IF NOT EXISTS ADD COLUMN name VARCHAR(200) NOT NULL;
      ALTER TABLE users IF EXISTS DROP COLUMN first_name;
      ALTER TABLE users IF EXISTS DROP COLUMN middle_name;
      ALTER TABLE users IF EXISTS DROP COLUMN last_name;

      DELETE TYPE IF EXISTS gender_enum;
      ALTER TABLE users IF EXISTS DROP COLUMN gender;
      ALTER TABLE users IF EXISTS DROP COLUMN date_of_birth;
    SQL
  end
end

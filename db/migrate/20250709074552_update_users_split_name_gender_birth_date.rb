class UpdateUsersSplitNameGenderBirthDate < ActiveRecord::Migration[8.0]
  # update users remove name add firstname, lastname and middlename
  # add gender, date of birth
  def up
    execute <<~SQL
      CREATE TYPE gender_enum AS ENUM('male', 'female', 'not-specified');

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
      -- Add back name column with default to avoid NOT NULL constraint error
      ALTER TABLE users ADD COLUMN IF NOT EXISTS name VARCHAR(200) NOT NULL;

      -- Drop enum-dependent columns FIRST
      ALTER TABLE users DROP COLUMN IF EXISTS gender;

      -- Drop other new columns
      ALTER TABLE users DROP COLUMN IF EXISTS first_name;
      ALTER TABLE users DROP COLUMN IF EXISTS middle_name;
      ALTER TABLE users DROP COLUMN IF EXISTS last_name;
      ALTER TABLE users DROP COLUMN IF EXISTS date_of_birth;

      -- Drop enum type LAST (after dependent columns are gone)
      DROP TYPE IF EXISTS gender_enum;
    SQL
  end
end

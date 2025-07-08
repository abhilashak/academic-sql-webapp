class CreateUsers < ActiveRecord::Migration[8.0]
  def up
    # create users table
    execute <<~SQL
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(200) NOT NULL,
        email VARCHAR(150) NOT NULL,
        phone_number VARCHAR(20),
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );

      CREATE INDEX idx_users_email ON users(email);
    SQL
  end

  # drop users table
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS users;
    SQL
  end
end

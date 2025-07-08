class CreateProducts < ActiveRecord::Migration[8.0]
  # create table products
  def up
    execute <<~SQL
      CREATE TYPE category_enum AS ENUM ('men', 'women', 'kids', 'infants');

      CREATE TABLE products (
        id BIGSERIAL PRIMARY KEY,
        title VARCHAR(250) NOT NULL,
        description TEXT,
        price DECIMAL(10,2) NOT NULL CHECK (price > 0),
        category category_enum NOT NULL,
        stock_quantity INTEGER NOT NULL DEFAULT 0,
        active BOOLEAN DEFAULT true,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    SQL
  end

  # drop table products
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS products;
      DROP TYPE IF EXISTS category_enum;
    SQL
  end
end

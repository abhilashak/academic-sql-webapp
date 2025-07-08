class CreateOrders < ActiveRecord::Migration[8.0]
  def up
    # create table orders
    execute <<~SQL
      CREATE TABLE orders (
        id BIGSERIAL PRIMARY KEY,
        user_id BIGINT NOT NULL,
        product_id BIGINT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

        CONSTRAINT fk_orders_user_id
          FOREIGN KEY (user_id) REFERENCES users(id)
          ON DELETE CASCADE ON UPDATE CASCADE,

        CONSTRAINT fk_orders_product_id
          FOREIGN KEY (product_id) REFERENCES products(id)
          ON DELETE CASCADE ON UPDATE CASCADE
      );

      CREATE INDEX idx_orders_user_id ON orders(user_id);
      CREATE INDEX idx_orders_product_id ON orders(product_id);
    SQL
  end

  def down
    # drop table orders
    execute <<~SQL
      DROP TABLE IF EXISTS orders;
    SQL
  end
end

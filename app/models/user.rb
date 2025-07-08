# app/models/user.rb
class User < ApplicationRecord
  has_many :orders
  validates :name, presence: true
  validate :email, presence: true,
                   format: {
                    with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/,
                    message: "must be a valid email address"
                   },
                   uniqueness: { case_sensitive: false }

  # find all users who ordered N orders in last M days
  # using AR query method
  scope :with_min_orders_in_last_days, ->(min_orders:, days:) {
    select("users.*, count(orders.id) as order_count")
    .joins(:orders)
    .where("orders.created_at >= ?", days.days.ago)
    .group("users.id")
    .having("count(orders.id) >= ?", min_orders)
    .order("order_count desc")
  }

  # find all users who ordered N orders in last M days
  # using SQL query
  def self.min_orders_in_last_days(min_orders, days)
    find_by_sql([
        "SELECT users.*, count(orders.id) AS order_count
          FROM users
          JOIN orders ON users.id = orders.user_id
          WHERE orders.created_at >= ?
          GROUP BY users.id
          HAVING count(orders.id) >= ?
          ORDER BY order_count desc", days.days.ago, min_orders
    ])
  end
end

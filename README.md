# 📚 Academic SQL Software

A Rails 8 application that demonstrates direct SQL query execution using PostgreSQL. This app bypasses ActiveRecord's ORM methods in favor of raw SQL queries for complete database control.

## 🎯 Purpose & Approach

This application showcases advanced SQL operations and database interactions using direct SQL execution. Instead of relying on ActiveRecord's abstraction methods like `Student.where()` or `Teacher.joins()`, all database operations are performed using raw SQL queries.

### 🔧 SQL Operations Covered

- **Basic SQL Operations**: SELECT, INSERT, UPDATE, DELETE
- **Advanced Filtering**: WHERE clauses, LIKE patterns, IN/NOT IN
- **Table Joins**: INNER, LEFT, RIGHT, FULL OUTER joins
- **Aggregation Functions**: COUNT, MAX, MIN, AVG, SUM
- **Grouping & Sorting**: GROUP BY, HAVING, ORDER BY
- **Subqueries**: Correlated and non-correlated subqueries
- **Window Functions**: ROW_NUMBER, RANK, LAG, LEAD
- **Common Table Expressions (CTEs)**: Recursive and non-recursive
- **Query Optimization**: EXPLAIN plans and indexing strategies

## 🏗️ Architecture Approach

### Why Rails + ActiveRecord (but not the ORM)?

We use Rails with ActiveRecord for infrastructure benefits while bypassing ORM features:

**✅ What we USE from ActiveRecord:**
- Database connection management and pooling
- Rails console for interactive query testing
- Migration system for table schema management
- Database configuration and environment handling
- `ActiveRecord::Base.connection.execute()` for raw SQL execution

**❌ What we AVOID from ActiveRecord:**
- Model associations and validations
- ActiveRecord query methods (`.where`, `.joins`, `.group`)
- Callbacks and lifecycle methods
- Automatic SQL generation

### 🔧 Technology Stack

- **Ruby**: 3.3.0+ 
- **Rails**: 8.0+
- **Database**: PostgreSQL 14+
- **Adapter**: pg gem for direct PostgreSQL connectivity

## 📊 Database Schema

### Current Tables

```sql
-- Students table
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  age INTEGER,
  grade_level INTEGER,
  enrollment_date DATE,
  teacher_id INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Teachers table  
CREATE TABLE teachers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  subject VARCHAR(100),
  years_experience INTEGER,
  salary DECIMAL(10,2),
  hire_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 🔮 Future Tables (Planned)
- **Courses**: Course catalog and scheduling
- **Enrollments**: Many-to-many relationship between students and courses
- **Grades**: Student performance tracking
- **Departments**: Teacher organization and course categorization

## 🚀 Setup Instructions

### Prerequisites
- Ruby 3.3.0+
- PostgreSQL 14+
- Rails 8.0+

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd academic-sql-software

# Install dependencies
bundle install

# Create and setup database
rails db:create
rails db:migrate
rails db:seed

# Start the server
rails server
```

## 💻 Usage

### Direct SQL Execution in Rails Console

```bash
rails console
```

### Example Raw SQL Queries

```ruby
# Get database connection
conn = ActiveRecord::Base.connection

# Basic queries
conn.execute("SELECT * FROM students WHERE age > 18")
conn.execute("SELECT COUNT(*) FROM teachers WHERE years_experience > 5")

# Join queries
conn.execute("""
  SELECT s.name as student_name, t.name as teacher_name, t.subject
  FROM students s
  INNER JOIN teachers t ON s.teacher_id = t.id
  WHERE t.years_experience > 3
""")

# Advanced aggregations
conn.execute("""
  SELECT t.subject, 
         COUNT(s.id) as student_count,
         AVG(s.age) as average_age
  FROM teachers t
  LEFT JOIN students s ON t.id = s.teacher_id
  GROUP BY t.subject
  HAVING COUNT(s.id) > 2
""")
```

### 🌐 Web Interface

Navigate to `http://localhost:3000` to access SQL execution modules:

- **Query Builder**: Execute custom SQL queries with immediate results
- **Join Workshop**: Demonstrate different join types with data visualization
- **Performance Lab**: Compare query execution plans and analyze performance
- **Advanced Operations**: Complex SQL scenarios and edge cases

## 📚 SQL Modules

### 🔰 Basic Operations
1. **SELECT statements**: Filtering, sorting, and data retrieval
2. **Data modification**: INSERT, UPDATE, DELETE operations
3. **Simple aggregations**: COUNT, SUM, AVG, MIN, MAX

### 🔥 Intermediate Operations
1. **Table joins**: Complex relationship queries across multiple tables
2. **Subqueries**: Nested query strategies and optimization
3. **Window functions**: Advanced analytical queries and ranking

### 🚀 Advanced Operations
1. **Query optimization**: EXPLAIN plans, indexing, and performance tuning
2. **Complex CTEs**: Recursive queries and advanced data modeling
3. **Performance analysis**: Identifying and resolving query bottlenecks

## 🎯 Application Goals

This application demonstrates:

- Direct SQL query execution without ORM abstraction
- Complex database operations using raw PostgreSQL features
- Performance optimization techniques for SQL queries
- Advanced SQL patterns and best practices
- Set-based thinking and efficient database operations

## 🤝 Contributing

Contributions welcome for:
- Additional SQL operation examples
- New database tables and relationships
- Query optimization techniques
- Performance benchmarking scenarios

## 📝 License

This project is open source and available under the MIT License.

---

**Focus**: Direct SQL execution for complete database control and advanced PostgreSQL features.
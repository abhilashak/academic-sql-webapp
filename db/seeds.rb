# ==============================================================================
# MAIN SEED FILE - MODULAR ARCHITECTURE
# ==============================================================================
#
# This file orchestrates the seeding process using modular seeder classes.
# Each model has its own dedicated seeder for better organization and maintenance.
#
# Configuration:
# - Adjust constants in db/seeds/base_seeder.rb
# - Set CLEAR_DATA=true environment variable to clear existing data
#
# Usage:
#   rails db:seed                    # Seed with default settings
#   CLEAR_DATA=true rails db:seed    # Clear data first, then seed
#
# ==============================================================================

# Load all seeder classes
require_relative 'seeds/base_seeder'
require_relative 'seeds/users_seeder'
require_relative 'seeds/products_seeder'
require_relative 'seeds/courses_seeder'
require_relative 'seeds/schools_seeder'
require_relative 'seeds/orders_seeder'
require_relative 'seeds/students_seeder'

# Start the seeding process
BaseSeeder.seed_all

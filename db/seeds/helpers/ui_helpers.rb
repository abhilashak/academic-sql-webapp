# db/seeds/helpers/ui_helpers.rb
module UiHelpers
  class << self
    def progress_indicator(current, total, step = 1000)
      print "." if (current + 1) % step == 0
    end

    def print_section_header(title, emoji = "📋")
      puts "\n#{emoji} #{title}"
      puts "=" * (title.length + 4)
    end

    def print_subsection(title, emoji = "  •")
      puts "#{emoji} #{title}"
    end

    def print_success(message, count = nil)
      if count
        puts "✅ #{message}: #{count}"
      else
        puts "✅ #{message}"
      end
    end

    def print_warning(message)
      puts "⚠️  #{message}"
    end

    def print_error(message)
      puts "❌ #{message}"
    end

    def print_info(message)
      puts "ℹ️  #{message}"
    end

    def print_summary_box(title, data)
      puts "\n" + "=" * 60
      puts "📊 #{title}"
      puts "=" * 60

      data.each do |label, value|
        puts "   #{label}: #{value}"
      end

      puts "=" * 60
    end

    def print_verification_stats(stats)
      puts "\n🔍 Verification:"
      stats.each do |label, value|
        puts "   • #{label}: #{value}"
      end
      puts "\n🚀 Seed data ready for use!"
    end

    def print_timing_info(start_time, end_time, operation)
      duration = end_time - start_time
      puts "⏱️  #{operation} completed in #{duration.round(2)} seconds"
    end

    def print_memory_usage
      memory_usage = `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
      puts "💾 Memory usage: #{memory_usage.round(1)} MB"
    end

    def print_batch_progress(current, total, batch_size = 1000)
      if (current + 1) % batch_size == 0
        percentage = ((current + 1).to_f / total * 100).round(1)
        puts "📈 Progress: #{current + 1}/#{total} (#{percentage}%)"
      end
    end

    def print_dependency_info(dependencies)
      puts "\n🔗 Dependencies:"
      dependencies.each do |model, count|
        puts "   • #{model}: #{count} records"
      end
    end
  end
end

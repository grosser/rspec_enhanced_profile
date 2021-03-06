RspecEnhancedProfileBase = begin
  # RSpec 2
  require 'rspec/core/formatters/progress_formatter'
  RSpec::Core::Formatters::ProgressFormatter
rescue LoadError
  # RSpec 1
  require 'spec/runner/formatter/progress_bar_formatter'
  Spec::Runner::Formatter::ProgressBarFormatter
end

class RspecEnhancedProfile < RspecEnhancedProfileBase
  SHOW_TOP = (ENV['PROFILE_SHOW_TOP'] || 20).to_i

  def initialize(*args)
    super
    @example_times = []
  end

  def start(*args)
    @output.puts "Profiling enabled."
  end

  def example_started(*args)
    @time = Time.now
  end

  def example_passed(example)
    super
    @example_times << [
      example_group.description,
      example.description,
      Time.now - @time
    ]
  end

  def start_dump
    dump_group_times
    dump_example_times

    @output.flush
  end

  private

  def dump_example_times
    @output.puts "\n\nSingle examples:\n"

    sorted_by_time(@example_times)[0..SHOW_TOP].each do |group, example, time|
      @output.puts "#{red(sprintf("%.7f", time))} #{group} #{example}"
    end
  end

  def dump_group_times
    @output.puts "\n\nGroups:\n"

    group_times = Hash.new(0)
    @example_times.each do |group, example, time|
      group_times[group]+=time
    end

    sorted_by_time(group_times)[0..SHOW_TOP].each do |group,time|
      @output.puts "#{red(sprintf("%.7f", time))} #{group}"
    end
  end

  #sorted by last ascending
  def sorted_by_time(times)
    times.to_a.sort_by{|x| x.last}.reverse
  end
end

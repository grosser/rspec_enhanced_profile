require 'spec/runner/formatter/progress_bar_formatter'

class RspecEnhancedProfile <  Spec::Runner::Formatter::ProgressBarFormatter
  SHOW_TOP = 20

  def initialize(options, where)
    super
    @example_times = []
  end

  def method_missing(method, *args)
    # ignore
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
    sort_times
    dump_group_times
    dump_example_times

    @output.flush
  end

  private

  def sort_times
    @example_times = @example_times.sort_by {|data| data.last}.reverse
  end

  def dump_example_times
    @output.puts "\n\nSingle examples:\n"

    @example_times[0..SHOW_TOP].each do |group, example, time|
      @output.print red(sprintf("%.7f", time))
      @output.puts " #{group} #{example}"
    end
  end

  def dump_group_times
    @output.puts "\n\nGroups:\n"

    grouped_times = {}
    @example_times.each do |group, example, time|
      grouped_times[group]||=0
      grouped_times[group]+=time
    end

    grouped_times.to_a.sort_by{|k_and_v| k_and_v[1]}.reverse[0..SHOW_TOP].each do |k_and_v|
      @output.print red(sprintf("%.7f", k_and_v[1]))
      @output.puts " #{k_and_v[0]}"
    end
  end
end
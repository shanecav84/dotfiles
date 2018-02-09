#! /usr/bin/env ruby

require 'time'

class TimerScript
  def initialize(argv)
    @argv = argv
  end

  def run
    if @argv[0] == 'start'
      File.open('/tmp/timerscript', 'w') do |file|
        file.write(Time.now.to_s)
        file.close
      end
    elsif @argv[0] == 'stop'
      start_time = Time.parse(File.read('/tmp/timerscript'))
      print "#{(Time.now - start_time).to_i} seconds\n"
    end
  end
end

TimerScript.new(ARGV).run

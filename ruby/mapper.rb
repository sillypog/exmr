#!/usr/bin/env ruby

require 'date'
require 'json'

ARGF.each do |line|
  line = line.chomp

  # Each line is a json representation of one or more events
  data = JSON.parse line

  data['events'].each do |event|
    # Convert the event.timestamp to a day
    day = Time.at(event['data']['timestamp_unixtime_ms'] / 1000).utc.strftime("%Y-%m-%d")
    puts "#{day}\t1"
  end
end

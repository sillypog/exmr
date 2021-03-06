#!/usr/bin/env ruby

curr_key = nil
curr_count = nil

ARGF.each do |line|
  line = line.chomp

  key, value = line.split(/\t/)
  value = value.to_i

  if curr_key == nil
    curr_key = key
    curr_count = value
    next
  elsif curr_key != key && curr_count > 0
    puts "#{curr_key}\t#{curr_count.to_s}"  # outputting the previous value
    curr_key = key
    curr_count = value
  else
    curr_count += value
  end
end

# Make sure we print the final values.
puts "#{curr_key}\t#{curr_count.to_s}" unless curr_count < 1


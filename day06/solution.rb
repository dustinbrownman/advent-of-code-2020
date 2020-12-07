require 'set'

input = File.join(File.dirname(__FILE__), "input")

yes_count = 0

responses = File.read(input)

group_responses = responses.split("\n\n")

# Part 1
# group_responses.map! { |r| r..split("") }

# group_responses.each do |responses|
#   yes_count += responses.to_set.length
# end

# Part 2
group_responses.each do |gr|
  yes_count += gr.split("\n").map { |gr| gr.split("") }.inject(:&).length
end

p yes_count

require "set"

input = File.join(File.dirname(__FILE__), "input")

numbers = []

File.open(input).each do |line|
  numbers << line.to_i
end

def adds_to?(a, b, test_sum)
  a + b == test_sum
end

number_set = numbers.to_set

# two numbers
numbers.each do |n|
  difference = 2020 - n

  if number_set.include?(difference)
    puts difference * n
    break
  end
end

# three numbers
numbers.each do |n|
  difference = 2020 - n

  matching_set = nil

  numbers.each do |other_n|
    potential_set_member = difference - other_n

    if number_set.include?(potential_set_member)
      matching_set = [n, other_n, potential_set_member]
      break
    end
  end

  if matching_set
    puts matching_set[0] * matching_set[1] * matching_set[2]
    break
  end
end



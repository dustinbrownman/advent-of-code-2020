require "set"

input = File.join(File.dirname(__FILE__), "input")

numbers = []

File.open(input).each do |line|
  numbers << line.to_i
end

def pair_that_adds_to(numbers, testing_sum)
  number_set = numbers.to_set
  numbers.each do |n|
    difference = testing_sum - n

    if number_set.include?(difference)
      return [difference, n]
    end
  end
  nil
end

# two numbers
a, b = pair_that_adds_to(numbers, 2020)
puts a * b

# three numbers
numbers.each do |n|
  difference = 2020 - n

  a, b = pair_that_adds_to(numbers, difference)

  if a && b
    puts n * a * b
    break
  end
end

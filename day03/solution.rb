input = File.join(File.dirname(__FILE__), "input")

def traverse(start, x, y)
  start_x, start_y = start
  [start_x + x, start_y + y]
end

input_forest = File.readlines(input)

def trees_encountered(forest, slope)
  x, y = [0, 0]
  trees_encountered = 0

  while !forest[y].nil?
    forest_line = forest[y].strip # pesky newline characters
    repeat_point = forest_line.length
    current_space = forest_line[x % repeat_point]

    # is it a tree?
    if current_space == "#"
      trees_encountered += 1
    end

    x, y = traverse([x, y], *slope)
  end

  trees_encountered
end

test_slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2],
]

encounter_counts = test_slopes.map do |slope|
  trees_encountered(input_forest, slope)
end

puts encounter_counts # gut check
puts encounter_counts.inject(:*)

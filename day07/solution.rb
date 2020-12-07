require "set"

input = File.join(File.dirname(__FILE__), "input")

@bags = {}

# {
#   "shiny gold" => {
#     "contents" => [
#       {
#         "type" => "dim blue",
#         "amount" => 4
#       }
#     ],
#     "within" => [
#       "mirrored lime"
#     ]
#   }
# }

File.foreach(input) do |rule|
  bag_description, contents = rule.split(" contain")

  containing_bag = bag_description.gsub("bags", "").strip

  @bags[containing_bag] ||= { "contents" => [], "within" => [] }

  next if contents.include?("no other bags")

  contents.gsub(".", "").split(", ").each do |content|
    # "1 mirrored lime bag"
    amount = content.strip.scan(/\d+/).first.to_i
    type   = content.strip.scan(/\d+ (.*) bags*/).flatten.first

    @bags[containing_bag]["contents"].push({
      "type"   => type,
      "amount" => amount
    })

    @bags[type] ||= { "contents" => [], "within" => [] }

    @bags[type]["within"].push(containing_bag)
  end
end

my_bag = "shiny gold"

@possible_bags = Set.new

def containing_bags(color)
  within = @bags[color]["within"]
  @possible_bags.merge(within)

  if within.length > 0
    within.each { |bag| containing_bags(bag) }
  end
end

# Part 1
# containing_bags(my_bag)

# p @possible_bags.length
# p @possible_bags.include? my_bag

@number_of_bags_within = 0

def bags_contained_within(color)
  @bags[color]["contents"].each do |content|
    amount = content["amount"]
    @number_of_bags_within += amount

    # Get all the bags inside of each one
    amount.times { bags_contained_within(content["type"]) }
  end
end

bags_contained_within(my_bag)

p @number_of_bags_within

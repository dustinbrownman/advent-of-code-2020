input = File.join(File.dirname(__FILE__), "input")

class Policy
  def initialize(policy_string)
    min, max, character = policy_string.match(/(\d+)-(\d+) ([a-z])/).captures

    @min       = min.to_i
    @max       = max.to_i
    @character = character
  end

  def password_meets?(password)
    character_at_min?(password) ^ character_at_max?(password)
  end

  def pass_min?(password)
    @min <= password.scan(@character).count
  end

  def pass_max?(password)
    @max >= password.scan(@character).count
  end

  def character_at_min?(password)
    password[@min-1] == @character
  end

  def character_at_max?(password)
    password[@max-1] == @character
  end
end

def password_meets_policy?(policy_string, password)
  policy = Policy.new(policy_string)

  policy.password_meets?(password)
end

count = 0

File.readlines(input).each do |line|
  policy, password = line.split(": ")

  count += 1 if password_meets_policy?(policy, password)
end

puts count

input = File.join(File.dirname(__FILE__), "input")

class Passport < Struct.new(:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid, keyword_init: true)
  def valid?
    required_fields.all? { |field| valid_field?(field) }
  end

  private

  def required_fields
    [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]
  end

  def validator
    Validation.new(self)
  end

  def valid_field?(field)
    Validation.new(self, field).valid?
  end

  class Validation
    def initialize(object, field)
      @object = object
      @field  = field
      @value  = object.public_send(field)
    end

    def valid?
      return false if @value.nil?
      send(@field)
    end

    private

    def byr
      valid_year_range?(1920, 2002)
    end

    def iyr
      valid_year_range?(2010, 2020)
    end

    def eyr
      valid_year_range?(2020, 2030)
    end

    def valid_year_range?(lower, upper)
      @value.length == 4 && @value.to_i >= lower && @value.to_i <= upper
    end

    def hgt
      return false unless @value.match? /^\d+(cm|in)$/

      height, units = @value.scan(/^(\d+)(cm|in)$/).flatten

      case units
      when "in"
        height.to_i >= 59 && height.to_i <= 76
      when "cm"
        height.to_i >= 150 && height.to_i <= 193
      else
        false
      end
    end

    def hcl
      @value.match? /^#[0-9a-f]{6}$/
    end

    def ecl
      %w(amb blu brn gry grn hzl oth).include? @value
    end

    def pid
      @value.match? /^\d{9}$/
    end

    def cid
      true
    end
  end
end

def create_passport(raw_passport_data)
  passport_params = {}

  raw_passport_data.split(/\s/).each do |kv_pair|
    key, value = kv_pair.split(":")

    passport_params[key.to_sym] = value
  end

  Passport.new(passport_params)
end

valid_passports = 0

File.read(input).split("\n\n").each do |raw_passport_data|
  passport = create_passport(raw_passport_data)

  if passport.valid?
    valid_passports += 1
    p passport
  end
end

puts valid_passports

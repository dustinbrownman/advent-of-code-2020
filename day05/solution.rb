require 'set'

input = File.join(File.dirname(__FILE__), "input")

class BoardingPass
  def initialize(seat_number)
    @row    = seat_number.slice(0, 7)
    @column = seat_number.slice(7, 10)
  end

  def seat_id
    @seat_id ||= (row * 8) + column
  end

  def row
    binary_row.to_i(2)
  end

  def column
    binary_column.to_i(2)
  end

  private

  def binary_row
    @row.gsub("F", "0").gsub("B", "1")
  end

  def binary_column
    @column.gsub("L", "0").gsub("R", "1")
  end
end

seat_ids = Set.new
lowest_seat_id = 10_000
highest_seat_id = 0

File.foreach(input) do |seat_number|
  boarding_pass = BoardingPass.new(seat_number.strip)

  seat_ids.add(boarding_pass.seat_id)

  if boarding_pass.seat_id < lowest_seat_id
    lowest_seat_id = boarding_pass.seat_id
  end

  if boarding_pass.seat_id > highest_seat_id
    highest_seat_id = boarding_pass.seat_id
  end
end

missing_seat_id = (lowest_seat_id..highest_seat_id).find do |seat_id|
  !seat_ids.include? seat_id
end

puts missing_seat_id

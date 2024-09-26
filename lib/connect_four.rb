# frozen_string_literal: true

class ConnectFour
  def initialize
    @grid = Array.new(7) { [] }
  end

  def newGrid
    @grid = Array.new(7) { [] }
  end

  def addToken(column_id, token)
    if @grid[column_id].length == 6
      puts "This column is full, try another"
      return false
    end

    @grid[column_id] << token
    return true
  end

  def checkVerticalFour
    @grid.each do |column|
      return true if column.length >= 4 && column[-4..].uniq.size == 1
    end

    return false
  end

  def checkHorizontalFour
    6.times do |num|
      horizonal_line = @grid.map { |column| column[num] }
      4.times do |idx|
        slice = horizonal_line[idx..idx + 3]
        return true if !slice[0].nil? && slice.uniq.size == 1
      end
    end

    return false
  end
end

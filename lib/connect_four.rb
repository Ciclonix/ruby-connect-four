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
      return true if column.length >= 4 && column[-4..].uniq.size <= 1
    end
    return false
  end
end

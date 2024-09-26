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
    6.times do |column_id|
      horizontal_line = @grid.map { |column| column[column_id] }
      4.times do |line_id|
        slice = horizontal_line[line_id..line_id + 3]
        return true if !slice[0].nil? && slice.uniq.size == 1
      end
    end

    return false
  end

  def checkDiagonalFour
    return checkFrontDiagonals || checkBackDiagonals
  end

  def checkFrontDiagonals
    4.times do |column_id|
      3.times do |line_id|
        diagonal_line = [
          @grid[column_id][line_id],
          @grid[column_id + 1][line_id + 1],
          @grid[column_id + 2][line_id + 2],
          @grid[column_id + 3][line_id + 3]
        ]
        return true if !diagonal_line[0].nil? && diagonal_line.uniq.size == 1
      end
    end
    return false
  end

  def checkBackDiagonals
    4.times do |column_id|
      column_id = 6 - column_id
      3.times do |line_id|
        diagonal_line = [
          @grid[column_id][line_id],
          @grid[column_id - 1][line_id + 1],
          @grid[column_id - 2][line_id + 2],
          @grid[column_id - 3][line_id + 3]
        ]
        return true if !diagonal_line[0].nil? && diagonal_line.uniq.size == 1
      end
    end
    return false
  end
end

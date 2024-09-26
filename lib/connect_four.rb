# frozen_string_literal: true

class ConnectFour
  def initialize
    @grid = Array.new(7) { [] }
  end

  def newGrid
    @grid = Array.new(7) { [] }
  end

  def addToken(column_id, token)
    unless column_id.between?(0, 6)
      puts "error: invalid column"
      return false
    end

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

  def isWin?
    return checkVerticalFour || checkHorizontalFour || checkDiagonalFour
  end

  def gridFull?
    lengths = @grid.map(&:length).uniq
    return lengths[0] == 6 && lengths.size == 1
  end

  def inputPlayers
    print "Player 1, choose a name: "
    player1[:id] = gets.chomp
    player1[:symbol] = "⚪"
    print "Player 2, choose a name: "
    player2[:id] = gets.chomp
    player2[:symbol] = "⚫"
    return [player1, player2]
  end

  def turn(player)
    print "Player #{player[:id]} choose column: "
    column_id = gets.chomp
    raise ArgumentError unless addToken(column_id.to_i, player[:symbol])
  rescue ArgumentError
    puts "error: invalid column"
    retry
  end

  def play(players)
    # printGrid
    loop do
      players.each do |player|
        turn(player)
        return player if isWin?
        return nil if gridFull?

        # printGrid
      end
    end
  end

  def startGame
    winner = play(inputPlayers)
    if winner.nil?
      puts "Draw!"
    else
      puts "Congratulations! Player #{winner[:id]} won!"
    end
  end
end

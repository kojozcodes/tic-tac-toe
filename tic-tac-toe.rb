class Board
  def initialze
    @board = Array.new(3) {Array.new(3, ' ')}
  end

  def display_board
    puts "  1 2 3"
    @board.each_with_index do |row, index|
      print "#{index + 1} "
      row.each_with_index do |cell, cell_index|
        print "#{cell}"
        print "|" unless cell_index == 2
      end
      puts ""
      puts "  _____" unless index == 2
    end

    def place_symbol(row, col,  symbol)
      @board[row][col] = symbol if @board[row][col] == ' '
    end

    def check_winner(symbol)
      #check rows
      @board.each do |row|
        return true if row.all? { |cell| cell == symbol }
      end

      #check columns
      @board.transpose.each do |col|
        return true if col.all? { |cell| cell == symbol }
      end

      #check diagonals
      diagonals = [
        [@board[0][0], @board[1][1], @board[2][2]],
        [@board[0][2], @board[1][1], @board[2]02]
      ]
      diagonals.each do |diagonal|
        return true if diagonal.all? { |cell| cell == symbol }
      end


      false
    end

    def is_board_full
      @board.all? { |row| row.none? { |cell| cell == ' ' } }
    end
end

class Player

end


class Game

end
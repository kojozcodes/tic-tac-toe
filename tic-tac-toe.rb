class Board
  def initialize
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
  end

    def place_symbol(row, col, symbol)
      return false if @board[row][col] != ' '
      @board[row][col] = symbol
      true
    end

    def check_winner
      # Check rows
      @board.each do |row|
        return row.first if row.uniq.length == 1 && row.first != ' '
      end
  
      # Check columns
      @board.transpose.each do |col|
        return col.first if col.uniq.length == 1 && col.first != ' '
      end
  
      # Check diagonals
      diagonals = [
        [@board[0][0], @board[1][1], @board[2][2]],
        [@board[0][2], @board[1][1], @board[2][0]]
      ]
      diagonals.each do |diagonal|
        return diagonal.first if diagonal.uniq.length == 1 && diagonal.first != ' '
      end
  
      nil
    end

    def full_board?
      @board.all? { |row| row.none? { |cell| cell == ' ' } }
    end
end


class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move
    puts "#{@name}, it's your turn. Enter the row (1-3) and column (1-3) to place your #{@symbol}:"
    print "> "
    row, col = gets.chomp.split.map(&:to_i)
    [row - 1, col - 1]
  end
end


class Game
  def initialize
    @board = Board.new
    @players = []
  end

  def start_game
    puts "Welcome to Tic Tac Toe!"
    setup_players
    play_turn until game_over?
    end_game
  end

  private

  def setup_players
    [1, 2].each do |player_number|
      puts "Player #{player_number}, enter your name:"
      print "> "
      name = gets.chomp
      symbol = (player_number == 1) ? 'X' : 'O'
      @players << Player.new(name, symbol)
    end
  end


  def play_turn
    @board.display_board
    current_player = @players.first
    row, col = current_player.make_move
    until @board.place_symbol(row, col, current_player.symbol)
      puts "That cell is already taken. Try again."
      row, col = current_player.make_move
    end
    switch_players
  end

  def switch_players
    @players.rotate!
  end

  def game_over?
    @board.check_winner || @board.full_board?
  end

  def end_game
    @board.display_board
    if @board.check_winner
      winning_player = @players.find { |player| player.symbol == @board.check_winner }
      puts "#{winning_player.name} wins!"
    else
      puts "It's a tie!"
    end
  end
end

game = Game.new

game.start_game
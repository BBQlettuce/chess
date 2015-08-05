require_relative 'chessboard'

class Game
  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  def initialize(player1, player2)
    @player1 = player1
    player1.color = :white
    @player2 = player2
    player2.color = :black
    @current_player = player1
    @board = Chessboard.new
  end

  def play
    until board.over?
      board.render
      begin
        start_pos, end_pos = current_player.play_turn
        board.move(start_pos, end_pos, current_player.color)
      rescue ArgumentError => e
        puts e.message
        retry
      end
      switch_player
    end
    board.render
    switch_player
    puts "Congratulations #{current_player.name}! You won!"

  end

  def switch_player
    self.current_player = (current_player == player1) ? player2 : player1
  end

end

class HumanPlayer

  EASY_COLS = ("a".."h").to_a
  EASY_ROWS = ["8", "7", "6", "5", "4", "3", "2", "1"]

  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn
    begin
    start_pos = prompt_start
    end_pos = prompt_end
    rescue
      puts "Please enter a valid position"
      retry
    end
    [start_pos, end_pos]
  end

  def prompt_start
    puts "#{name}'s turn! Make your move. Please enter the piece you want to move: "
    start_input = gets.chomp.split("")
    col = EASY_COLS.index(start_input[0])
    row = EASY_ROWS.index(start_input[1])
    start_pos = [row, col]
    start_pos.map { |el| Integer(el) }
  end

  def prompt_end
    puts "Please enter where you want to move to: "
    end_input = gets.chomp.split("")
    col = EASY_COLS.index(end_input[0])
    row = EASY_ROWS.index(end_input[1])
    end_pos = [row, col]
    end_pos.map { |el| Integer(el) }
  end

end

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new("A")
  p2 = HumanPlayer.new("B")
  game = Game.new(p1, p2)
  game.play
end

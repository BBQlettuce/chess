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
      current_player.play_turn
      switch_player
    end
    switch_player
    puts "Congratulations #{current_player.name}! You won!"

  end

  def switch_player
    current_player = (current_player == player1) ? player2 : player1
  end

end

class HumanPlayer
  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
    #@color = nil
  end

  def play_turn
    begin
    start_pos = prompt_start
    rescue
      puts "Please enter a valid position"
      retry
    end

    begin
    end_pos = prompt_end
    rescue
      puts "Please enter a valid position"
      retry
    end

    begin
      board.move(start_pos, end_pos)
    rescue ArgumentError => e
      puts e.message
      retry
    end

  end

  def prompt_start
    puts "Make your move. Please enter the piece you want to move: "
    start_input = gets.chomp.split(",")
    start_pos = start_input.map(&:to_i)
  end

  def prompt_end
    puts "Make your move. Please enter where you want to move to: "
    end_input = gets.chomp.split(",")
    send_pos = start_input.map(&:to_i)
  end

end

class Chessboard

  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8)}
    @pieces = pieces

  end

  def generate_new_board

  end

  def in_check(color)

  end

  def occupied_by_enemy?(pos, color)
    occupied?(pos) && self[[pos]].color != color
  end

  def available?(pos)
    !occupied?(pos) && self.class.in_board?(pos)
  end

  def self.in_board?(pos)
    pos.all?{|position| position.between?(0, 7)}
  end

  def occupied?(pos)
    !board[pos].nil?
  end

  def [](pos)
    row, col = pos
    board[row][col]
  end

end

class Chessboard

  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8)}

  end

  def generate_new_board

  end

  def in_board?(pos)
    pos.all?{|position| position.between?(0, 7)}
  end

  def occupied?(pos)
    board[pos].nil?
  end

  def [](pos)
    row, col = pos
    board[row][col]
  end

end

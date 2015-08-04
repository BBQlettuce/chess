class Piece

  attr_reader :board

  def initialize(pos, board)
    @board = board
    @moves = moves
    @pos = pos
  end

  def moves(pos)

  end

end

class SlidingPiece < Piece

  VERTICALS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

  def moves(pos)
    move_dirs.each do |(x,y)|
      new_x = pos[0] + x
      new_y = pos[1] + y
      until !new_x.between?(0,7) || !new_y.between?(0,7)
        moves << [new_x, new_y]
        new_x += x
        new_y += y
      end
    end
  end

end

class SteppingPiece < Piece
  KNIGHT_STEPS = [
    [-1, -2], [-1, 2], [1, -2], [1, 2],
    [-2, -1], [-2, 1], [2, -1], [2, 1]]
  KING_STEPS =
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  def moves(pos)
    move_dirs.each do |(x,y)|
      new_x = pos[0] + x
      new_y = pos[1] + y
      moves << [new_x, new_y] if new_x.between?(0,7) && new_y.between?(0,7)
    end
  end

end


class Bishop < SlidingPiece

  def move_dirs
    DIAGONALS
  end

end

class Rook < SlidingPiece

  def move_dirs
    VERTICALS
  end

end

class Queen < SlidingPiece

  def move_dirs
    VERTICALS + DIAGONALS
  end

end

class Knight < SteppingPiece
  def move_dirs
    KNIGHT_STEPS
  end
end

class King < SteppingPiece
end

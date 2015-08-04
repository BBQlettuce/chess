class Piece

  attr_reader :board

  def initialize(pos, board)
    @board = board
    @moves = moves
    @pos = pos
  end

  def moves(pos)
    move_dirs.each do |(x,y)|
      new_x = pos[0] + x
      new_y = pos[1] + y
      until new_x > 7 || new_y > 7
        moves << [new_x, new_y]
        new_x += x
        new_y += y
      end
    end
  end

end

class SlidingPiece < Piece

  VERTICALS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

end

class SteppingPiece < Piece

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

end

class King < SteppingPiece
end

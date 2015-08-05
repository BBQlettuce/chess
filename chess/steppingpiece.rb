require_relative 'piece'

class SteppingPiece < Piece

  KNIGHT_STEPS = [
    [-1, -2], [-1, 2], [1, -2], [1, 2],
    [-2, -1], [-2, 1], [2, -1], [2, 1]]
  KING_STEPS =
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  def moves(board)
    moves = []
    move_dirs.each do |(x,y)|
      new_x = pos[0] + x
      new_y = pos[1] + y
      next_pos = [new_x, new_y]
      if board.available?(next_pos) || board.occupied_by_enemy?(next_pos, color)
        moves << next_pos
      end
    end
    moves
  end

end

class Knight < SteppingPiece

  def appearance
    "N"
  end

  def move_dirs
    KNIGHT_STEPS
  end
end

class King < SteppingPiece

  def appearance
    "K"
  end

  def move_dirs
    KING_STEPS
  end
end

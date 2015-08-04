class Piece

  attr_reader :board, :color
  attr_accessor :moves, :pos

  def initialize(pos)
    #@board = board
    #@moves = moves
    @pos = pos
    #@color = color
  end

  def moves(pos)

  end

  def valid_move(pos)

  end

  def move_into_check?(pos)

  end


end

class SlidingPiece < Piece

  VERTICALS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

  def moves(pos)
    moves = []
    move_dirs.each do |(x,y)|
      # until we hit another Piece (value isnt nil) or go off the board
      new_x = pos[0] + x
      new_y = pos[1] + y
      next_pos = [new_x, new_y]
      until !board.available?(next_pos)
        moves << next_pos
        new_x += x
        new_y += y
        next_pos = [new_x, new_y]
      end
      if Chessboard.in_board?(next_pos) &&
          board.occupied_by_enemy?(next_pos, color)
        moves << next_pos
      end
    end
    self.moves = moves
  end

end

class SteppingPiece < Piece
  KNIGHT_STEPS = [
    [-1, -2], [-1, 2], [1, -2], [1, 2],
    [-2, -1], [-2, 1], [2, -1], [2, 1]]
  KING_STEPS =
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  def moves(pos)
    moves = []
    move_dirs.each do |(x,y)|
      new_x = pos[0] + x
      new_y = pos[1] + y
      next_pos = [new_x, new_y]
      if board.available?(next_pos) || board.occupied_by_enemy?(next_pos, color)
        moves << next_pos
      end
    end
    self.moves = moves
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
  def move_dirs
    KING_STEPS
  end
end

class Pawn < Piece
  DIAG_MOVES = [1, -1]
  WHITE_DIR = -1
  BLACK_DIR = 1
  def moves
    moves = []
    case color
    when white
      if board.available?([pos[0] + WHITE_DIR, pos[1]])
        moves << [pos[0] + WHITE_DIR, pos[1]]
      end
      DIAG_MOVES.each do |diag|
        diag_move = [pos[0] + WHITE_DIR, pos[1] + diag]
        if Chessboard.in_board?(diag_move) &&
            board.occupied_by_enemy?(diag_move, color)
          moves << diag_move
        end
      end
    else
      if board.available?([pos[0] + BLACK_DIR, pos[1]])
        moves << [pos[0] + BLACK_DIR, pos[1]]
      end
      DIAG_MOVES.each do |diag|
        diag_move = [pos[0] + BLACK_DIR, pos[1] + diag]
        if Chessboard.in_board?(diag_move) &&
            board.occupied_by_enemy?(diag_move, color)
          moves << diag_move
        end
      end
    end
    self.moves = moves
  end

end

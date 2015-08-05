require_relative 'piece'

class SlidingPiece < Piece

  VERTICALS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

  def moves(board)
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
    moves
  end

end

class Bishop < SlidingPiece

  def appearance
    #"B"
    "\u{2657}"
  end

  def move_dirs
    DIAGONALS
  end

end

class Rook < SlidingPiece

  def appearance
    #"R"
    "\u{2656}"
  end

  def move_dirs
    VERTICALS
  end

end

class Queen < SlidingPiece

  def appearance
    #"Q"
    "\u{2655}"
  end

  def move_dirs
    VERTICALS + DIAGONALS
  end

end

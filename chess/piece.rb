require 'colorize'

class Piece

  attr_accessor :moves, :pos, :color, :board

  def initialize(pos)
    @pos = pos
    #@board = nil
    #@moves = nil
    @color = nil
  end

  # def moves(pos)
  #
  # end

  def valid_moves
    valid_moves = moves.select do |move|
      !move_into_check?(move)
    end
    @moves = valid_moves
    valid_moves
  end

  def dup_board(board)
    board.board.map { |el| el.is_a?(Array) ? dup_board(el) : el }
  end

  def move_into_check?(end_pos)
    board_dup = dup_board(board)
    board_dup.move(pos, end_pos)
    !board_dup.in_check(color)
  end

  def to_s
    appearance.colorize(color)
  end

end

class Pawn < Piece

  def appearance
    "P"
  end

  DIAG_MOVES = [1, -1]
  WHITE_DIR = -1
  BLACK_DIR = 1
  def moves
    moves = []
    case color
    when :white
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
    @moves = moves
  end

end

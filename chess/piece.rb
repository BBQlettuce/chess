require 'colorize'

class Piece

  attr_accessor :moves, :pos, :color, :board, :valid_moves

  def initialize(pos)
    @pos = pos
    #@board = nil
    #@moves = nil
    @color = nil
    @valid_moves = nil
  end

  # def moves(pos)
  #
  # end

  def find_valid_moves(board)
    valid_moves = moves(board).select do |move|
      !move_into_check?(move, board)
    end
    #@moves = valid_moves
    self.valid_moves = valid_moves
  end

  #to be changed
  def dup_board(board)
    dup_pieces = []
    board.pieces.each do |piece|
      dup_pieces << self.class.dup_piece(piece)
    end
    Chessboard.new(dup_pieces)
  end

  def self.dup_piece(piece)
    dup_position = piece.pos.dup
    new_piece = piece.class.new(dup_position)
    new_piece.color = piece.color
    new_piece
  end

  def move_into_check?(end_pos, board)
    board_dup = dup_board(board)
    board_dup.make_fake_move(pos, end_pos)
    board_dup.in_check?(color)
  end

  def to_s
    appearance.colorize(color)
  end

end

class Pawn < Piece

  def appearance
    #"P"
    "\u{2659}"
  end

  DIAG_MOVES = [1, -1]
  WHITE_DIR = -1
  BLACK_DIR = 1

  def moves(board)
    moves = []
    case color
    when :white
      if pos[0] == 6
        moves << [4, pos[1]] if board.available?([4, pos[1]])
      end
      moves + straight_moves(pos, WHITE_DIR, board) +
      diag_moves(pos, WHITE_DIR, board)
    else
      if pos[0] == 1
        moves << [3, pos[1]] if board.available?([3, pos[1]])
      end
      moves + straight_moves(pos, BLACK_DIR, board) +
      diag_moves(pos, BLACK_DIR, board)
    end
  end

  def straight_moves(pos, direction, board)
    moves = []
    if board.available?([pos[0] + direction, pos[1]])
      moves << [pos[0] + direction, pos[1]]
    end
    moves
  end

  def diag_moves(pos, direction, board)
    moves = []
    DIAG_MOVES.each do |diag|
      diag_move = [pos[0] + direction, pos[1] + diag]
      if Chessboard.in_board?(diag_move) &&
          board.occupied_by_enemy?(diag_move, color)
        moves << diag_move
      end
    end
   moves
  end

end

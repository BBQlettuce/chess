require_relative 'slidingpiece'
require_relative 'steppingpiece'

class Chessboard

  attr_accessor :board, :pieces

  def initialize
    @board = Array.new(8) {Array.new(8)}
    @pieces = []
    generate_new_board
    pass_board_to_pieces
  end

  def move(start_pos, end_pos)
    # first check if start pos is valid: if out of board, enemy piece, or empty
    unless occupied?(start_pos)
      raise "No piece at #{start_pos}"
    end
    current_piece = self[start_pos]
    unless current_piece.valid_moves.include?(end_pos)
      raise "Invalid move"
    end
    # move piece
    if occupied_by_enemy?(end_pos, current_piece.color)
      kill_piece(end_pos)
    end
    current_piece.pos = end_pos

  end

  def kill_piece(pos)
    piece = self[pos]
    pieces.delete(piece)
  end

  def in_check?(color)
    king = find_king(color)
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king.pos)
    end
  end

  def checkmate?(color)
    #in check && no valid moves
    team_pieces = pieces.select {|piece| piece.color == color}
    no_valid_moves = team_pieces.all? do |piece|
      piece.valid_moves.length == 0
    end
    in_check?(color) && no_valid_moves
  end

  def find_king(color)
    king = pieces.select do |piece|
      piece.is_a?(King) && piece.color == color
    end
    king = king.first
  end

  def occupied_by_enemy?(pos, color)
    occupied?(pos) && self[[pos]].color != color
  end

  def available?(pos)
    !occupied?(pos) && Chessboard.in_board?(pos)
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

  def []=(pos, piece)
    row, col = pos
    board[row][col] = piece
  end

  def render
    board.each do |row|
      row.each do |cell|
        if cell.nil?
          print " _ "
        else
          print " #{cell.to_s} "
        end
      end
      print "\n"
    end
  end


  private

  def generate_new_board
    #populates board with pieces
    place_pawns
    place_rooks
    place_knights
    place_bishops
    place_queens
    place_kings
    color_pieces
  end

  def place_pawns
    [1,6].each do |row|
      (0..7).each do |col|
        self[[row, col]] = Pawn.new([row,col])
      end
    end
  end

  def place_rooks
    [0, 7].each do |row|
      [0, 7].each do |col|
        self[[row, col]] = Rook.new([row, col])
      end
    end
  end

  def place_knights
    [0, 7].each do |row|
      [1, 6].each do |col|
        self[[row, col]] = Knight.new([row, col])
      end
    end
  end

  def place_bishops
    [0, 7].each do |row|
      [2, 5].each do |col|
        self[[row, col]] = Bishop.new([row, col])
      end
    end
  end

  def place_queens
    [0, 7].each do |row|
      self[[row, 3]] = Queen.new([row,  3])
    end
  end

  def place_kings
    [0, 7].each do |row|
      self[[row, 4]] = King.new([row, 4])
    end
  end

  def color_pieces
    (0..7).each do |col|
      [0, 1].each do |row|
        self[[row, col]].color = :black
        pieces << self[[row, col]]
      end
      [6, 7].each do |row|
        self[[row, col]].color = :white
        pieces << self[[row, col]]
      end
    end
  end

  def pass_board_to_pieces
    pieces.each do |piece|
      piece.board = self
    end
  end
end

if __FILE__ == $PROGRAM_NAME

end

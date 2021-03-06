require_relative 'slidingpiece'
require_relative 'steppingpiece'
require 'byebug'
class Chessboard

  attr_accessor :board, :pieces

  def initialize(pieces = [])
    @board = Array.new(8) {Array.new(8)}
    @pieces = pieces
    generate_board(pieces)
  end

  def move(start_pos, end_pos, color)
    # first check if start pos is valid: if out of board, enemy piece, or empty
    unless occupied?(start_pos)
      raise ArgumentError.new "No piece at #{start_pos}"
    end
    current_piece = self[start_pos]
    unless current_piece.color == color
      raise ArgumentError.new "You can't move your opponent's piece!"
    end
    current_piece_moves = current_piece.find_valid_moves(self)
    unless current_piece_moves.include?(end_pos)
      raise ArgumentError.new "Invalid move."
    end
    # move piece
    if occupied_by_enemy?(end_pos, current_piece.color)
      kill_piece(end_pos)
    end
    self[start_pos] = nil
    current_piece.pos = end_pos
    self[end_pos] = current_piece
  end

  def kill_piece(pos)
    piece = self[pos]
    pieces.delete(piece)
  end

  def in_check?(color)
    king = find_king(color)
    pieces.any? { |piece| piece.moves(self).include?(king.pos) }
  end

  def make_fake_move(start_pos, end_pos)
    current_piece = self[start_pos]
    if occupied_by_enemy?(end_pos, current_piece.color)
      kill_piece(end_pos)
    end
    current_piece.pos = end_pos
  end

  def in_checkmate?(color)
    #in check && no valid moves

    team_pieces = pieces.select {|piece| piece.color == color}
    team_pieces.each { |piece| piece.find_valid_moves(self)}
    no_valid_moves = team_pieces.all? do |piece|
      piece.valid_moves.empty?
    end
    in_check?(color) && no_valid_moves
  end

  def over?
    in_checkmate?(:black) || in_checkmate?(:white)
  end

  def winner
    in_checkmate?(:black) ? :white : :black if over?
  end

  def find_king(color)
    king = pieces.select do |piece|
      piece.is_a?(King) && piece.color == color
    end
    king = king.first
  end

  def occupied_by_enemy?(pos, color)
    #debugger
    occupied?(pos) && self[pos].color != color
  end

  def available?(pos)
    # debugger
    Chessboard.in_board?(pos) && !occupied?(pos)
  end

  def self.in_board?(pos)
    #return false if pos.nil?
    pos.all? { |position| position.between?(0, 7) }
  end

  def occupied?(pos)
  #  debugger if pos.nil?
    Chessboard.in_board?(pos) && !self[pos].nil?
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

  def generate_board(pieces)
    unless pieces.empty?
      pieces.each do |piece|
        board_pos = piece.pos
        self[board_pos] = piece
      end
    else
      generate_new_board
    end
  end

  def generate_new_board
    #populates board with pieces
    place_pawns
    place_piece(Rook, [0,7])
    place_piece(Knight, [1,6])
    place_piece(Bishop, [2,5])
    place_piece(Queen, [3])
    place_piece(King, [4])
    color_pieces
  end

  def place_pawns
    [1,6].each do |row|
      (0..7).each do |col|
        self[[row, col]] = Pawn.new([row,col])
      end
    end
  end

  def place_piece(type_of_piece, spots)
    [0, 7].each do |row|
      spots.each do |col|
        self[[row, col]] = type_of_piece.new([row, col])
      end
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
  
end

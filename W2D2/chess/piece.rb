require 'singleton'

class Piece
  attr_reader :color, :symbol

  def initialize(color, symbol, board)
    @color = color
    @symbol = symbol
    @board = board
  end
end

class Array
  def in_bounds?
    self.any? { |coord| coord < 0 || coord > 7 }
  end
end

module SlidingPiece
  def move_dirs(start_pos, is_horizontal_vertical, is_diagonal)
    all_moves = []
  if is_horizontal_vertical
    duped = start_pos
    until duped.any? { |coord| coord > 7 }
      all_moves << duped
      duped = [duped.first+1, duped.last]
    end

    duped = start_pos
    until duped.any? { |coord| coord < 0 }
      all_moves << duped
      duped = [duped.first-1, duped.last]
    end

    duped = start_pos
    until duped.any? { |coord| coord > 7 }
      all_moves << duped
      duped = [duped.first, duped.last+1]
    end

    duped = start_pos
    until duped.any? { |coord| coord < 0 }
      all_moves << duped
      duped = [duped.first, duped.last-1]
    end
  end

  if is_diagonal
    duped = start_pos
    until duped.any? { |coord| coord > 7 }
      all_moves << duped
      duped = [duped.first + 1, duped.last + 1]
    end

    duped = start_pos
    until duped.any? { |coord| coord > 7 || coord < 0 }
      all_moves << duped
      duped = [duped.first - 1, duped.last + 1]
    end

    duped = start_pos
    until duped.any? { |coord| coord < 0 }
      all_moves << duped
      duped = [duped.first - 1, duped.last - 1]
    end

    duped = start_pos
    until duped.any? { |coord| coord > 7 || coord < 0 }
      all_moves << duped
      duped = [duped.first + 1, duped.last - 1]
    end
  end
  all_moves.delete(start_pos)
  all_moves
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :white
    @symbol = " "
  end
end

class Bishop < Piece
  include SlidingPiece

  def moves(start_pos)
    move_dirs(start_pos, is_horizontal_vertical = false, is_diagonal = true)
  end
end

class Rook < Piece
  include SlidingPiece
  def moves(start_pos)
    move_dirs(start_pos, is_horizontal_vertical = true, is_diagonal = false)
  end
end

class Queen < Piece
  include SlidingPiece
  def moves(start_pos)
    move_dirs(start_pos, is_horizontal_vertical = true, is_diagonal = true)
  end
end

class King < Piece
  def moves(start_pos)
    all_moves = []
    (-1..1).each do |shift|
      all_moves << [(start_pos.first + shift), start_pos.last + 1]
      all_moves << [(start_pos.first - shift), start_pos.last - 1]
      all_moves << [(start_pos.first + shift), start_pos.last]
    end
    all_moves.delete(start_pos)
    all_moves.reject { |move| move.in_bounds? }
  end
end

class Knight < Piece
  def moves(start_pos)
    shifts = [[2,1], [1,2], [-2,1], [-1,2], [2,-1], [-2, -1], [1,-2], [-1,-2]]
    all_moves = []
    shifts.each do |shift|
      all_moves << [start_pos.first + shift.first, start_pos.last + shift.last]
    end
    all_moves.reject { |move| move.in_bounds? }
  end
end

class Pawn < Piece
  attr_reader :board

  def initialize(color, symbol, board)
    @first_move = true
    super
  end

  def moves(start_pos)
    x, y = start_pos
    all_moves = []
    if self.color == :red
      if @first_move
        all_moves << [start_pos.first + 2, start_pos.last]
        @first_move = false
      end
      all_moves << [x + 1, y]
      left_diagonal = [x + 1, y - 1]
      right_diagonal = [x + 1, y + 1]
      all_moves << left_diagonal unless board[left_diagonal].is_a?(NullPiece)
      all_moves << right_diagonal unless board[right_diagonal].is_a?(NullPiece)
    elsif self.color == :green
      if @first_move
        all_moves << [x - 2, y]
        @first_move = false
      end
      all_moves << [x - 1, y]
      left_diagonal = [x - 1, y - 1]
      right_diagonal = [x - 1, y + 1]
      all_moves << left_diagonal unless board[left_diagonal].is_a?(NullPiece)
      all_moves << right_diagonal unless board[right_diagonal].is_a?(NullPiece)
    end
    all_moves
  end
end

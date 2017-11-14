require_relative 'piece'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise ArgumentError.new("Invalid move. No piece exists at #{start_pos}.")
    elsif end_pos.in_bounds?
      raise ArgumentError.new("Invalid move. Please enter a coordinate between 0 and 7")
    elsif start_pos == end_pos
      raise ArgumentError.new("Invalid move. Cannot move piece into same place.")
    elsif self[start_pos].moves(start_pos).include?(end_pos)
      if !equal_colors?(start_pos, end_pos)
        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.instance
      else
        raise ArgumentError.new("Invalid move. Cannot capture your own piece.")
      end
    else
      raise ArgumentError.new("Invalid move. Piece cannot make that move.")
    end

    self
  end

  def equal_colors?(start_pos, end_pos)
    self[start_pos].color == self[end_pos].color
  end

  # def colliding?(start_pos, end_pos)
  #   delta_x = (end_pos[0] - start_pos[0]).abs
  #   delta_y = (end_pos[1] - start_pos[1]).abs
  #   if self[start_pos].is_a?(Rook)
  #     if delta_y.zero?
  #       y_max = [start_pos.last, end_pos.last].max
  #       y_min = [start_pos.last, end_pos.last].min
  #       ((y_min + 1)...y_max).each do |y|
  #         return true unless @grid[start_pos[0], y].is_a?(NullPiece)
  #       end
  #     elsif delta_y.zero?
  #
  #     end
  #   end
  # end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def checkmate?(color)

  end

  def in_check?(color)

  end

  def over?
    self.checkmate?(:red) || self.checkmate?(:green)
  end

  def populate
    red_non_pawns = [Rook.new(:red, :r, self), Knight.new(:red, :n, self),
                Bishop.new(:red, :b, self), Queen.new(:red, :q, self),
                King.new(:red, :k, self), Bishop.new(:red, :b, self),
                Knight.new(:red, :n, self), Rook.new(:red, :r, self)]
    red_pawns = Array.new(8) { Pawn.new(:red, :p, self) }

    green_non_pawns = [Rook.new(:green, :r, self), Knight.new(:green, :n, self),
                Bishop.new(:green, :b, self), Queen.new(:green, :q, self),
                King.new(:green, :k, self), Bishop.new(:green, :b, self),
                Knight.new(:green, :n, self), Rook.new(:green, :r, self)]

    green_pawns = Array.new(8) { Pawn.new(:green, :p, self) }

    @grid.map!.with_index do |rows, idx|
      case idx
      when 0 then red_non_pawns
      when 1 then red_pawns
      when 2, 3, 4, 5 then Array.new(8) { NullPiece.instance }
      when 6 then green_pawns
      when 7 then green_non_pawns
      end
    end
  end


end

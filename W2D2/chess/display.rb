require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render_with_cursor
    while true
      render_board
      @cursor.get_input
    end
  end

  def render_board
    system('clear')
    @board.grid.each_with_index do |row, x|
      row.map.with_index do |piece, y|
        if [x, y] == @cursor.cursor_pos
          print "| #{piece.symbol.to_s.colorize(color: :blue, background: :yellow)} | "
        else
          print "| #{piece.symbol.to_s.colorize(piece.color)} | "
        end
      end
      puts
      puts '------------------------------------------------'
    end
    "potatoes"
  end


end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.render_with_cursor
end

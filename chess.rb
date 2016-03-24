#filled in colors = white

class Piece
	attr_accessor :captured, :space, :board
	attr_reader :color
	
	

	def initialize(space, color)
		@space = space
		@color = color
		
	end	

	def capture
		@space = 0
		@@captured << self
	end

	def self.captured
		@@captured
	end
	
	def move(space)
		@space.piece = nil
		@space = space
		space.piece = self
	end
		


end

class Bishop < Piece
	@white = "\u265d "
	@black = "\u2657 "

end

class King < Piece
	@white = "\u265a "
	@black = "\u2654 "
end

class Knight < Piece
	@white = "\u265e "
	@black = "\u2658 "

end

class Pawn < Piece
	@white = "\u265f "
	@black = "\u2659 "

end

class Queen < Piece
	@white = "\u265b "
	@black = "\u2655 "

end

class Rook < Piece
	@white = "\u265c "
	@black = "\u2656 "

end

class Space

	attr_reader :xcoord, :ycoord, :color, :board
	attr_accessor :piece
	@@white = "\u25a3 "
	@@black = "\u25a2 " 
	

	def initialize(xcoord, ycoord)
		@xcoord = xcoord
		@ycoord = ycoord
		@piece = nil
		(xcoord + ycoord).even? ? @color = @@black : @color = @@white
		
	end

	def self.make_board
		@@board = {}
		('a'..'h').to_a.each_with_index{|x, i| ('1'..'8').to_a.each_with_index{|y, j| 
			@@board[(x+y).to_sym] = Space.new(i, j)
		}}
	end

	def self.board 
		@@board
	end

	def self.display
		('1'..'8').to_a.reverse!.each{|y|
			('a'..'h').to_a.each {|x|
				if @@board[(x+y).to_sym].occupied? 
					print @@board[(x+y).to_sym].piece
				else
					print @@board[(x+y).to_sym].color
				end
			} 
			puts ""
		}
	end

	def occupied?
		@piece == nil ? false : true
	end

end


class Player





end

Space.make_board
Space.display





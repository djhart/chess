#filled in colors = white

class Piece
	attr_accessor :captured, :space, :board
	attr_reader :color
	

	def initialize(space, color)
		@space = space
		@color = color
		@space.piece = self
		@@captured ||= []

		
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

	def self.populate(board)
		board.each {|x, y| y.piece = Pawn.new(y, "white")}
	end
		


end

class Bishop < Piece
	@@white = "\u265d "
	@@black = "\u2657 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end

end

class King < Piece
	@@white = "\u265a "
	@@black = "\u2654 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end

end

class Knight < Piece
	@@white = "\u265e "
	@@black = "\u2658 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end


end

class Pawn < Piece
	@@white = "\u265f "
	@@black = "\u2659 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end


end

class Queen < Piece
	@@white = "\u265b "
	@@black = "\u2655 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end


end

class Rook < Piece
	@@white = "\u265c "
	@@black = "\u2656 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		
	end


end

class Space

	attr_reader :xcoord, :ycoord, :color, :board
	attr_accessor :piece
	@@white = "\u25a3 "
	@@black = "\u25a2 " 
	

	def initialize(xcoord, ycoord)
		@xcoord = xcoord
		@ycoord = ycoord
		@piece = piece
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
					print @@board[(x+y).to_sym].piece.color
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
#board = Bishop.new(Space.board[:c1], "white")
Piece.populate(Space.board)
Space.display
#print board

#print Space.board[:b2].piece.color





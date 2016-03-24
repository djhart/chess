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

	def self.display
		@@board.each_with_index {|x,i| x.each_with_index {|y,j| 
			if y == 0  
				if (i+j)%2 == 0 
					print @@black
				else 
					print @@white
				end
			else
				print y
			end}
		puts ""}
	end

	def self.board
		@@board
	end

	def move(space)
		@space = space
	end
		


end

class Bishop < Piece

end

class King < Piece

end

class Knight < Piece

end

class Pawn < Piece

end

class Queen < Piece

end

class Rook < Piece

end

class Space

	attr_reader :xcoord, :ycoord, :color, :board
	attr_accessor :piece
	@@white = "\u25a2 "
	@@black = "\u25a3 " 
	

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





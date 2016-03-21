class Piece
	attr_accessor :captured, :coord
	attr_reader :color

	def initialize(coord, color)
		@coord = coord
		@color = color
		@@captured = []
	end

	def capture
		@coord = 0
		@@captured << self
	end

	def self.captured
		@@captured
	end




end

class Player





end


class Space




end

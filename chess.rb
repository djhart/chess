#filled in colors = white

class Piece
	attr_accessor :captured, :space, :board, :pieces
	attr_reader :color, :player, :type	

	def initialize(space, color)
		@space = space
		@color = color
		@space.piece = self
		@@captured ||= []
		@@pieces ||= []
		@@pieces << self
		@player = color
		@history = []		
	end	

	def self.key(arr)
		a = ('a'..'h').to_a
		return (a[arr[0]] + (arr[1] + 1).to_s).to_sym
	end

	def self.pieces
		@@pieces
	end

	def capture
		@space = 0
		@@captured << self
		@@pieces.delete(self)
	end

	def self.captured
		@@captured
	end
	
	def move(dest)
		@space.piece = nil
		@history << @space
		@space = dest
		@space.piece = self
	end

	def self.populate(board)
		board.each {|x, y|
			case x
			when :a1, :h1
				y.piece = Rook.new(y,"white")
			when :b1, :g1
				y.piece = Knight.new(y,"white")
			when :c1, :f1
				y.piece = Bishop.new(y,"white")
			when :d1
				y.piece = Queen.new(y,"white")
			when :e1
				y.piece = King.new(y,"white")
			when :a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2
				y.piece = Pawn.new(y,"white")
			when :a8, :h8
				y.piece = Rook.new(y,"black")
			when :b8, :g8
				y.piece = Knight.new(y,"black")
			when :c8, :f8
				y.piece = Bishop.new(y,"black")
			when :d8
				y.piece = Queen.new(y,"black")
			when :e8
				y.piece = King.new(y,"black")
			when :a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7
				y.piece = Pawn.new(y,"black") 
			end
		}
	end
end

class Bishop < Piece
	@@white = "\u265d "
	@@black = "\u2657 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		@type = "bishop"		
	end

	def legal?(dest)
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]
		legal = true
		if dest.occupied?
			if dest.piece.player == @player
				legal = false
			end
		end

		if (x.abs == y.abs) && legal == true
			tempx = @space.coord[0]
			tempy = @space.coord[1]
			a = dest.coord[0] <=> @space.coord[0]
			b = dest.coord[1] <=> @space.coord[1]
			until [tempx, tempy] == dest.coord
				tempx += a
				tempy += b
				tempkey = Piece.key([tempx, tempy])
				if !(@@pieces.find {|c| c.space == Space.board[tempkey]} == nil)
					legal = false unless  [tempx, tempy] == dest.coord				
				end
			end
		else
			legal = false
		end
		return legal
	end
end

class King < Piece
	@@white = "\u265a "
	@@black = "\u2654 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black		
		@type = "king"
	end

	def legal?(dest)
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]
		legal = true
		legal = false unless (x.abs <= 1) && (y.abs <= 1)
		if dest.occupied?
  		if dest.piece.player == @player
    		legal = false
    	end
    end	
    return legal
	end
end

class Knight < Piece
	@@white = "\u265e "
	@@black = "\u2658 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black		
		@type = "knight"
	end

	def legal?(dest)
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]
		legal = true
		legal = false unless ((x.abs == 1) && (y.abs == 2)) || ((x.abs == 2) && (y.abs == 1))

		if dest.occupied?
  		if dest.piece.player == @player
    		legal = false
    	end
    end		
  return legal
	end
end

class Pawn < Piece
	@@white = "\u265f "
	@@black = "\u2659 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		@type = "pawn"
	end

	def legal?(dest)
		legal = true
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]

		unless (((y == -1) || (y == -2)) && @player == "white") || (((y == 1) || (y == 2)) && @player == "black") 
	  	legal = false
		end

		if (y.abs == 2) && !(@history.empty?)
  		legal = false
		end


		if dest.occupied?
  		if dest.piece.player == @player
    		legal = false
	  	elsif !(x.abs == 1)
  		  legal = false
	  	end
		end

		if x.abs > 1
	  	legal = false
		end

		if x.abs == 1 			
  		legal = false unless dest.occupied?	  	
  	end
 	  return legal
  end
end

class Queen < Piece
	@@white = "\u265b "
	@@black = "\u2655 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black
		@type = "queen"
	end

	def legal?(dest)
		legal = true
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]

		if dest.occupied?
			if dest.piece.player == @player
				legal = false
			end
		end

		if ((x.abs == y.abs) && legal == true) || (((x.abs == 0) ||  (y.abs == 0)) && legal == true)
			tempx = @space.coord[0]
			tempy = @space.coord[1]
			a = dest.coord[0] <=> @space.coord[0]
			b = dest.coord[1] <=> @space.coord[1]
				until [tempx, tempy] == dest.coord
					tempx += a
					tempy += b
					tempkey = Piece.key([tempx, tempy])
					if !(@@pieces.find {|c| c.space == Space.board[tempkey]} == nil)
						legal = false unless  [tempx, tempy] == dest.coord
					end
				end
		else
			legal = false
		end
		return legal
	end
end

class Rook < Piece
	@@white = "\u265c "
	@@black = "\u2656 "
	def initialize(space, color)
		super
		@color == "white" ? @color = @@white : @color = @@black		
		@type = "rook"
	end

	def legal?(dest)
		legal = true
		x = @space.coord[0] - dest.coord[0]
		y = @space.coord[1] - dest.coord[1]
		if dest.occupied?
			if dest.piece.player == @player
				legal = false
			end
		end

		if (x.abs == 0) ||  (y.abs == 0) && legal == true
			tempx = @space.coord[0]
			tempy = @space.coord[1]
			a = dest.coord[0] <=> @space.coord[0]
			b = dest.coord[1] <=> @space.coord[1]
			until [tempx, tempy] == dest.coord
				tempx += a
				tempy += b
				tempkey = Piece.key([tempx, tempy])
				if !(@@pieces.find {|x| x.space == Space.board[tempkey]} == nil)
					legal = false unless  [tempx, tempy] == dest.coord
				end
			end

			else
				legal = false
			end
		return legal
	end
end

class Space

	attr_reader :xcoord, :ycoord, :color, :board#, :cartesian
	attr_accessor :piece
	@@white = "\u25a3 "
	@@black = "\u25a2 " 
	

	def initialize(xcoord, ycoord)
		@xcoord = xcoord
		@ycoord = ycoord
		@piece = piece
		(xcoord + ycoord).even? ? @color = @@black : @color = @@white
		
	end

	def coord
		return [@xcoord, @ycoord]
	end

	def self.make_board
		@@board = {}
		#@@cartesian =  Array.new(8) {Array.new(8)}	
		('a'..'h').to_a.each_with_index{|x, i| ('1'..'8').to_a.each_with_index{|y, j| 
			@@board[(x+y).to_sym] = Space.new(i, j)
			#@@cartesian[i][j] = @@board[(x+y).to_sym]
		}}
	end

	def self.board 
		@@board
	end

	#def self.cartesian
		#@@cartesian
	#end

	def self.display
		('1'..'8').to_a.reverse!.each{|y|
			print "#{y} "
			('a'..'h').to_a.each {|x|
				if @@board[(x+y).to_sym].occupied? 
					print @@board[(x+y).to_sym].piece.color
				else
					print @@board[(x+y).to_sym].color
				end
			} 
			puts ""
		}
		print "  A B C D E F G H"
		puts ""
	end

	def occupied?
		@piece == nil ? false : true
	end
end

class Player

	attr_reader :color, :king
	def initialize(color)
		@color = color
		@king = Piece.pieces.detect{|x| (x.player == @color) && (x.type == "king")}
	end

	def turn(board)
		
		done = false
		until done
		start, targetKey = 0
			until board.key?(start) && board.key?(targetKey)
				Space.display
				puts "#{@color}: move which piece?"
				start = gets.chomp.to_sym
				piece = board[start].piece
				puts piece
				puts "to which square"
				targetKey = gets.chomp.to_sym
				target = board[targetKey]
				puts target
			end

			cap = nil

			if target.occupied?
				cap = target.piece
			end

			if piece.legal?(target)
				piece.move(target)
				if !check?(cap) 
					done = true
					cap.capture if cap
				else
					piece.move(piece.history[-2])
					2.times {|i| piece.history.delete_at(-1)}
					if cap
						cap.move(target)
						cap.history.delete_at(-1)
					end
				end
			end
		end
	end

	def check?(cap = nil)
		check = false
		enemy = Piece.pieces.select {|x| (x.player != @color) || x != cap}		
		enemy.each{|y| check = true if y.legal?(@king.space)}
		return check
	end
end

Space.make_board
Piece.populate(Space.board)
#Space.display
playerOne = Player.new("white")
playerTwo = Player.new("black")
puts playerOne.king
turnCount = 0
checkmate = false

while checkmate == false
	if turnCount % 2 == 0
		playerOne.turn(Space.board)
		puts playerOne.king
		turnCount += 1
		puts turnCount
	else
		playerTwo.turn(Space.board)
		turnCount += 1
		puts turnCount
	end
end


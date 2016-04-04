require 'spec_helper.rb'

describe Player do 
	
	describe "#initialize" do
		it "makes a player" do
			@test = Player.new("white")
			expect(@test).to be_an_instance_of Player
		end
	end

	describe "#check?" do 
		it "looks for check" do
			Space.make_board
			Piece.pieces.clear			
			King.new(Space.board[:c4],"white")
			@test = Player.new("white")
			Queen.new(Space.board[:d6],"black")
			expect(@test.check?).to eql(false)
			Queen.new(Space.board[:c8],"black")
			expect(@test.check?).to eql(true)
		end
	end
end

describe Piece do 

	before :each do 
		Space.make_board
		Piece.populate(Space.board)
		@whiteRa1 = Space.board[:a1].piece
	end

	describe "#new" do 
		it "makes a piece" do
			expect(@whiteRa1).to be_an_instance_of Rook
		end
	end

	describe "#capture" do
		it "adds to captured and zeroes coord" do
			@whiteRa1.capture
			expect(@whiteRa1.space).to eql(0)
			expect(Piece.captured[0]).to eql(@whiteRa1)
		end
	end

	describe "#move" do 
		it "moves piece" do
			@whiteRa1.move(Space.board[:a5])
			expect(@whiteRa1.space).to eql(Space.board[:a5])
			expect(Space.board[:a1].piece).to eql(nil)
		end
	end

	describe "#key" do
		it "converts x, y coord to column rank notation" do 
			expect(Piece.key([0,0])).to eql(:a1)
			expect(Piece.key([2,6])).to eql(:c7)
		end
	end
end

describe Bishop do
	before :each do 
		Space.make_board
		@test = Bishop.new(Space.board[:c4], "white")
		Rook.new(Space.board[:e6],"black")
		King.new(Space.board[:a2], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:e6])).to eql(true)
			expect(@test.legal?(Space.board[:a2])).to eql(false)
			expect(@test.legal?(Space.board[:a6])).to eql(true)
			expect(@test.legal?(Space.board[:c6])).to eql(false)
		end
	end
end


describe Rook do
	before :each do 
		Space.make_board
		@test = Rook.new(Space.board[:a6], "white")
		Rook.new(Space.board[:e6],"black")
		King.new(Space.board[:a2], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:e6])).to eql(true)
			expect(@test.legal?(Space.board[:a2])).to eql(false)
			expect(@test.legal?(Space.board[:h6])).to eql(false)
			expect(@test.legal?(Space.board[:c6])).to eql(true)
		end
	end
end

describe King do
	before :each do 
		Space.make_board
		@test = King.new(Space.board[:c4], "white")
		Rook.new(Space.board[:d5],"black")
		Rook.new(Space.board[:c5],"black")
		Rook.new(Space.board[:a5],"black")
		King.new(Space.board[:b3], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:c5])).to eql(true)
			expect(@test.legal?(Space.board[:d5])).to eql(true)
			expect(@test.legal?(Space.board[:b3])).to eql(false)
			expect(@test.legal?(Space.board[:c6])).to eql(false)
			expect(@test.legal?(Space.board[:a6])).to eql(false)
			expect(@test.legal?(Space.board[:b4])).to eql(true)

		end
	end
end

describe Queen do
	before :each do 
		Space.make_board
		@test = Queen.new(Space.board[:c4], "white")
		Rook.new(Space.board[:e6],"black")
		King.new(Space.board[:a2], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:e6])).to eql(true)
			expect(@test.legal?(Space.board[:a2])).to eql(false)
			expect(@test.legal?(Space.board[:a6])).to eql(true)
			expect(@test.legal?(Space.board[:b6])).to eql(false)
			expect(@test.legal?(Space.board[:f7])).to eql(false)
			expect(@test.legal?(Space.board[:c6])).to eql(true)
			expect(@test.legal?(Space.board[:a4])).to eql(true)
			expect(@test.legal?(Space.board[:h8])).to eql(false)
		end
	end
end

describe Pawn do 
	before :each do 
		Space.make_board
		@test = Pawn.new(Space.board[:c4], "white")
		Rook.new(Space.board[:d5],"black")
		King.new(Space.board[:b5], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:e6])).to eql(false)
			expect(@test.legal?(Space.board[:c5])).to eql(true)
			expect(@test.legal?(Space.board[:c6])).to eql(true)
			expect(@test.legal?(Space.board[:d5])).to eql(true)
			expect(@test.legal?(Space.board[:f7])).to eql(false)
			expect(@test.legal?(Space.board[:c3])).to eql(false)
			expect(@test.legal?(Space.board[:b3])).to eql(false)
			expect(@test.legal?(Space.board[:b5])).to eql(false)
			expect(@test.legal?(Space.board[:h8])).to eql(false)
			Rook.new(Space.board[:c6],"black")
			expect(@test.legal?(Space.board[:c6])).to eql(false)
			Rook.new(Space.board[:c5],"black")			
			expect(@test.legal?(Space.board[:c5])).to eql(false)
			@test = Pawn.new(Space.board[:c4], "black")
			expect(@test.legal?(Space.board[:c3])).to eql(true)
			expect(@test.legal?(Space.board[:c2])).to eql(true)
			Rook.new(Space.board[:d3],"white")		
			Rook.new(Space.board[:c3],"white")	
			expect(@test.legal?(Space.board[:d3])).to eql(true)
			expect(@test.legal?(Space.board[:c3])).to eql(false)
			expect(@test.legal?(Space.board[:b3])).to eql(false)
		end
	end
end

describe Knight do 
	before :each do 
		Space.make_board
		@test = Knight.new(Space.board[:c4], "white")
		Rook.new(Space.board[:d6],"black")
		King.new(Space.board[:b6],"white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@test.legal?(Space.board[:e5])).to eql(true)
			expect(@test.legal?(Space.board[:d6])).to eql(true)
			expect(@test.legal?(Space.board[:b6])).to eql(false)
			expect(@test.legal?(Space.board[:d5])).to eql(false)
			expect(@test.legal?(Space.board[:f7])).to eql(false)
			expect(@test.legal?(Space.board[:d2])).to eql(true)
			expect(@test.legal?(Space.board[:b2])).to eql(true)
			expect(@test.legal?(Space.board[:a3])).to eql(true)
			expect(@test.legal?(Space.board[:a5])).to eql(true)
		end
	end
end	

describe Space do
	before :each do 
		Space.make_board
		Piece.populate(Space.board)
	end

	describe "#occupied?" do 
		it "checks if piece is on space" do
			expect(Space.board[:a1].occupied?).to eql(true)
			expect(Space.board[:a5].occupied?).to eql(false)
		end
	end
end



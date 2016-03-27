require 'spec_helper.rb'

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

describe Bishop do
	before :each do 
		Space.make_board
		@bish = Bishop.new(Space.board[:c4], "white")
		Rook.new(Space.board[:e6],"black")
		King.new(Space.board[:a2], "white")
	end


	describe "#legal?" do 
		it "checks legality of move" do
			expect(@bish.legal?(Space.board[:e6])).to eql(true)
			expect(@bish.legal?(Space.board[:a2])).to eql(false)
			expect(@bish.legal?(Space.board[:a6])).to eql(true)
			expect(@bish.legal?(Space.board[:c6])).to eql(false)
		end
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

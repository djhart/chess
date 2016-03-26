require 'spec_helper.rb'

describe Piece do 

	before :each do 
		Space.make_board
		@whiteRa1 = Piece.new(Space.board[:a1], "white")
	end

	describe "#new" do 
		it "makes a piece" do
			expect(@whiteRa1).to be_an_instance_of Piece
		end
	end

	describe "#capture" do
		it "adds to captured and zeroes coord" do
			@whiteRa1.capture
			expect(@whiteRa1.space).to eql(0)
			expect(Piece.captured[0]).to eql(@whiteRa1)
		end
	end
	
end

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
    ('a'..'h').to_a.each_with_index{|x, i| ('1'..'8').to_a.each_with_index{|y, j| 
      @@board[(x+y).to_sym] = Space.new(i, j)			
    }}
  end

  def self.board 
    @@board
  end

  

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
    print "CAPTURED: "
    Piece.captured.each {|x| print x.color}
    puts ""
  end

  def occupied?
    @piece == nil ? false : true
  end
end
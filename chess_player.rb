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
          puts "can't move into check"
          piece.move(piece.history[-1])
          2.times {|i| piece.history.delete_at(-1)}
          if cap
            cap.move(target)
            cap.history.delete_at(-1)
          end
        end
      else 
        puts "==illegal move=="
      end
    end
  end

  def check?(cap = nil)
    check = false
    enemy = Piece.pieces.select {|x| (x.player != @color) || x != cap}		
    enemy.each{|y| check = true if y.legal?(@king.space)}
    return check
  end

  def mate?
    mate = true
    test = Piece.pieces.select {|x| (x.player == @color)}  
    test.each{|y|
      moves = Space.board.select{|ind, space| y.legal?(space)}
      moves.each{|ind, space| 
        y.move(space)
        if space.occupied?
          cap = space.piece
        end

        if !check?(cap) 
          mate = false
        end

        y.move(y.history[-1])
          2.times {|i| y.history.delete_at(-1)}
          if cap
            cap.move(space)
            cap.history.delete_at(-1)
          end
      }
    }
    return mate
  end
end
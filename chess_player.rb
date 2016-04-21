require 'yaml'
class Player

  attr_reader :color, :king, :players
  def initialize(color)
    @color = color
    @king = Piece.pieces.detect{|x| (x.player == @color) && (x.type == "king")}
    @@players ||= []
    @@players << self
  end

  def save_game(data, name)
    yaml = YAML.dump(data)
    game_file = File.new("#{name}.yaml","w")
    game_file.write(yaml)
  end

  def load_game(name)
    game_file = File.new("#{name}.yaml","r")
    yaml = game_file.read
    YAML.load(yaml)
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
        puts piece.type
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
    #mate = false
    mate = true
    test = Piece.pieces.select {|x| (x.player == @color)}  
    test.each{|y|
      moves = Space.board.select{|ind, space| y.legal?(space)}
      #print "#{y} moves: #{moves}"
      moves.each{|ind, space| 
        #save_game(Piece.pieces, "temp_pieces")
        #save_game(Space.board, "temp_board")
        #save_game(@@players, "temp_players")
        
        cap = nil
        if space.occupied?
          cap = space.piece
        end

        y.move(space)

        if !check?(cap) 
          mate = false
        end

        if cap
            cap.move(space)
            cap.history.delete_at(-1)
        end

        y.move(y.history[-1])
        #puts y.space
        2.times {|i| y.history.delete_at(-1)}
        
      }
    }
    return mate
  end
end
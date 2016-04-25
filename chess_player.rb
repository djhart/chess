require 'yaml'
class Player

  class << self
    attr_accessor :players, :turnCount
  end


  attr_reader :color, :king
  #attr_accessor :turnCount, :players
  def initialize(color)
    @color = color
    @king = Piece.pieces.detect{|x| (x.player == @color) && (x.type == "king")}
    @@players ||= []
    @@players << self
    #@@turnCount = 0
  end

  #def self.turnCount
  #  @@turnCount
  #end

  def save_game(data, name)
    yaml = YAML.dump(data)
    game_file = File.new("#{name}.yaml","w")
    game_file.write(yaml)
  end  

  def turn(board, turnCount)
    
    done = false
    until done
      start, targetKey = 0
      save = [:s, :S]
      until (board.key?(start) && board.key?(targetKey)) || save.include?(start)
        Space.display
        puts "#{@color}: move which piece? S to save, L to load"
        start = gets.chomp.to_sym
        case start
        when :s, :S
          save_game(Piece.pieces, "pieces")
          save_game(Space.board, "board")
          save_game(@@players, "players")
          save_game(turnCount, "turnCount")
          puts "saved!"                  
        else
          piece = board[start].piece
          puts piece.type
          puts "to which square"
          targetKey = gets.chomp.to_sym
          target = board[targetKey]
          puts target
        end
      end

      if (board.key?(start) && board.key?(targetKey))
        cap = nil

        if target.occupied?
          cap = target.piece
        end

        if piece.legal?(target)
          piece.move(target)
          #@@turnCount += 1
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
        2.times {|i| y.history.delete_at(-1)}
        
      }
    }
    return mate
  end
end
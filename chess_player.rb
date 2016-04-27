require 'yaml'
class Player

  class << self
    attr_accessor :players, :turnCount
  end


  attr_reader :color, :king
  #attr_accessor :turnCount, :players
  def initialize(color, pieces)
    @color = color
    @king = pieces.detect{|x| (x.player == @color) && (x.type == "king")}
    @@players ||= []
    @@players << self
    #@@turnCount = 0
  end

  def display(board, captured)
    ('1'..'8').to_a.reverse!.each{|y|
      print "#{y} "
      ('a'..'h').to_a.each {|x|
        if board[(x+y).to_sym].occupied? 
          print board[(x+y).to_sym].piece.color
        else
          print board[(x+y).to_sym].color
        end
      } 
      puts ""
    }
    print "  A B C D E F G H"
    puts ""
    print "CAPTURED: "
    captured.each {|x| print x.color} unless captured.empty?
    puts ""
  end

def save_game(game)
  yaml = YAML.dump(game)
  game_file = File.new("chess_game.yaml","w")
  game_file.write(yaml)
end  

  

  def turn(game)
    board = game[:board]
    pieces = game[:pieces]
    captured = game[:captured]
    done = false
    until done
      start, targetKey = 0 
      save = [:s, :S]     
      until (board.key?(start) && board.key?(targetKey)) || save.include?(start)
        display(board, captured)
        puts "#{@color}: move which piece? S to save."
        start = gets.chomp.to_sym
        if save.include?(start)
          save_game(game)
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
          if !check?(cap, pieces) 
            done = true
            if cap
              cap.capture
              return cap
            else
              return nil
            end
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

  def check?(cap = nil, pieces)
    check = false
    enemy = pieces.select {|x| (x.player != @color) || x != cap}		
    enemy.each{|y| check = true if y.legal?(@king.space)}
    return check
  end

  def mate?(board, pieces)
    mate = true
    test = pieces.select {|x| (x.player == @color)}  
    test.each{|y|
      moves = board.select{|ind, space| y.legal?(space)}
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
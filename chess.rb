require_relative 'chess_pieces'
require_relative 'chess_player'
require_relative 'chess_board'
require 'yaml'

def load(name)
  game_file = File.new("#{name}.yaml","r")
  yaml = game_file.read
  YAML.load(yaml)
end

def load_game
  Piece.pieces = load("pieces")
  Space.board = load("board")
  Player.players = load("players")
  #turnCount = load("turnCount")
end

puts "Load? [Y/N]"

if gets.chomp.upcase == "Y"
  load_game
else
  Space.make_board
  Piece.populate(Space.board)
  playerOne = Player.new("white")
  playerTwo = Player.new("black")
  #turnCount = 0
end

checkmate = false
turnCount = 0




while checkmate == false
  if turnCount % 2 == 0
    if playerOne.check?
      if playerOne.mate?
        checkmate = true
        puts "#{playerTwo.color} WINS!"
      else
        playerOne.turn(Space.board, turnCount)
        turnCount += 1
        puts "turn number: #{turnCount}"  
      end
    else
        playerOne.turn(Space.board, turnCount)
        turnCount += 1
        puts "turn number: #{turnCount}"
    end
  else
    if playerTwo.check?
      if playerTwo.mate?
        checkmate = true
        puts "#{playerOne.color} WINS!"
      else
        playerTwo.turn(Space.board, turnCount)
        turnCount += 1
        puts "turn number: #{turnCount}"  
      end
    else
      playerTwo.turn(Space.board, turnCount)
      turnCount += 1
      puts "turn number: #{turnCount}" 
    end
  end
end


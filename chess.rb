require_relative 'chess_pieces'
require_relative 'chess_player'
require_relative 'chess_board'
require 'yaml'

def load
  game_file = File.new("chess_game.yaml","r")
  yaml = game_file.read
  YAML.load(yaml)
end

#def save_game
#  yaml = YAML.dump(game)
#  game_file = File.new("chess_game.yaml","w")
#  game_file.write(yaml)
#end  

puts "Load? [Y/N]"

if gets.chomp.upcase == "Y"
  game = load
else
  Space.make_board
  Piece.populate(Space.board)
  playerOne = Player.new("white", Piece.pieces)
  playerTwo = Player.new("black", Piece.pieces)
  turnCount = 0
end

if game.empty?
  game = {:board => Space.board, :players => [playerOne, playerTwo], :pieces => Piece.pieces, :turn => turnCount} 
end

def play(game)
  checkmate = false

  while checkmate == false
    player = game[:players][game[:turn] % 2]
    enemy = game[:players][(game[:turn] + 1) % 2]
    if player.check?(game[:pieces])
      if player.mate?(game[:board], game[:pieces])
        checkmate = true
        puts "#{enemy.color} WINS!"
      else
        player.turn(game)
        game[:turn] += 1
        puts "turn number: #{game[:turn]}"  
      end
    else
     player.turn(game)
     game[:turn] += 1
     puts "turn number: #{game[:turn]}"
    end  
  end
end

play(game)


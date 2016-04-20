require_relative 'chess_pieces'
require_relative 'chess_player'
require_relative 'chess_board'


Space.make_board
Piece.populate(Space.board)
#Space.display
playerOne = Player.new("white")
playerTwo = Player.new("black")
puts playerOne.king
turnCount = 0
checkmate = false

while checkmate == false
  if turnCount % 2 == 0
    if playerOne.mate?
      checkmate = true
      puts "#{playerTwo.color} WINS!"
    else
      playerOne.turn(Space.board)
      puts playerOne.king
      turnCount += 1
      puts turnCount
    end
  else
    if playerTwo.mate?
      checkmate = true
      puts "#{playerOne.color} WINS!"
    else
      playerTwo.turn(Space.board)
      turnCount += 1
      puts turnCount
    end
  end
end


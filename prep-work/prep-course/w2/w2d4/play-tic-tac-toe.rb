load 'lib/tic-tac-toe.rb'
load 'lib/board.rb'
load 'lib/computer-player.rb'
load 'lib/human-player.rb'


player1 = ComputerPlayer.new("Katie", :x, :expert)
player2 = ComputerPlayer.new("Snoopy", :o, :novice)
game = TicTacToe.new(player1, player2)
game.play

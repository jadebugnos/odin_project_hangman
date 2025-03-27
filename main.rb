require "rubocop"
require "pry-byebug"
require "json"
require_relative "lib/game"
require_relative "lib/player"

player = Player.new("jade")
new_game = Game.new(player)

# next task will be to refactor main.rb so that
# the we will prompt the player if he want to load the game or
# start a new game. so unexpected behavior is mitigated
new_game.start_game

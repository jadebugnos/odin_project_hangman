require "rubocop"
require "pry-byebug"
require "json"
require_relative "lib/game"
require_relative "lib/player"

player = Player.new("jade")
new_game = Game.new(player)

new_game.start_game

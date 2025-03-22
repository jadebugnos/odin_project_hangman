require "rubocop"
require "pry-byebug"
require_relative "lib/game"
require_relative "lib/player"

words = File.read(File.join(__dir__, "words.txt")).strip.split
player = Player.new
new_game = Game.new(words, player)

new_game.start_game

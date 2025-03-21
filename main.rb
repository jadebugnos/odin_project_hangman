require "rubocop"
require_relative "lib/game"
require_relative "lib/player"

words = File.read(File.join(__dir__, "words.txt")).strip.split

new_game = Game.new(words)

new_game.start_game

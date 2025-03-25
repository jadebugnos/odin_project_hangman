require "rubocop"
require "pry-byebug"
require "json"
require_relative "lib/game"
require_relative "lib/player"

player = Player.new
new_game = Game.new(player)

new_game.start_game

def load_words
  File.read(File.join(__dir__, "words.txt")).strip.split
end

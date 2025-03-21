# this file defines the game class logic
require_relative "game_instructions"
class Game
  def initialize(words, player)
    @words = words
    @player = player
    @secret_word = nil
  end

  def start_game
    game_intro
    choose_secret_word

  end

  def choose_secret_word
    secret_word = @words.filter { |word| word.size.between?(5, 12) }.sample
    @secret_word = secret_word
  end

  def game_intro
    slow_print(GameInstructions::INSTRUCTIONS[:intro])
  end

  def slow_print(text)
    text.each_char do |char|
      print char
      sleep(0.03)
    end
    puts
  end
end

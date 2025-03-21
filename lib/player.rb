# this file defines the player class logic
class Player
  def initialize
    @name = nil
    @guesses_history = []
  end

  def guess_word
    guess = gets.chomp
    @guesses_history << guess
  end
end

# this file defines the player class logic
class Player
  attr_accessor :name, :guesses_history

  def initialize
    @name = nil
    @guesses_history = []
  end

  def guess_word
    puts "Guess: "
    guess = validate_guess
    @guesses_history << guess
    guess
  end

  def validate_guess
    loop do
      guess = gets.chomp.downcase
      return guess if guess.size == 1 && ("a".."z").include?(guess)

      puts "Error: Unexpected input! Please type a letter"
    end
  end
end

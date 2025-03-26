# this file defines the player class logic
class Player
  include Serializable

  attr_accessor :name, :guesses_history

  def initialize(name = nil)
    @name = name || "word breaker"
  end

  def guess_word
    puts "Type your guess: "
    validate_guess
  end

  def validate_guess
    loop do
      guess = gets.chomp.downcase
      return guess if guess.size == 1 && ("a".."z").include?(guess)

      puts "Error: Unexpected input! Please type a letter"
    end
  end

  def validate_player_answer
    restart = ""

    loop do
      puts "do you want to play again? y/n"
      restart = gets.chomp.downcase

      raise "Invalid input! Please enter y or n" unless %w[y n].include?(restart)

      break
    rescue StandardError => e
      puts e.message
    end
    restart
  end
end

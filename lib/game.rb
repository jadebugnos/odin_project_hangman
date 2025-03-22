require_relative "game_instructions"

# this file defines the game class logic
class Game
  def initialize(words, player)
    @words = words
    @player = player
    @secret_word = @words.filter { |word| word.size.between?(5, 12) }.sample
    @blank_placeholders = Array.new(@secret_word.size, "__")
  end

  def start_game
    game_intro
    # choose_secret_word
    game_loop
  end

  def game_loop
    p @secret_word
    6.times do
      display_secret_word
      guess = @player.guess_word
      compare_guess_to_word(guess)
    end
  end

  # def choose_secret_word
  #   secret_word = @words.filter { |word| word.size.between?(5, 12) }.sample
  #   @secret_word = secret_word.chars
  #   p @secret_word
  # end

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

  def display_secret_word
    puts "Secret Word: "
    puts @blank_placeholders.join(" ")
  end

  def compare_guess_to_word(guess)
    @secret_word.each_char.with_index do |char, index|
      @blank_placeholders[index] = guess if char == guess
    end
  end
end

require_relative "game_instructions"

# this file defines the game class logic
class Game
  def initialize(words, player)
    @words = words
    @player = player
    @secret_word = @words.filter { |word| word.size.between?(5, 12) }.sample
    @blank_placeholders = Array.new(@secret_word.size, "__")
    @guess_history = []
    @tries = 6
  end

  def start_game
    game_intro
    play_rounds
  end

  def play_rounds
    while @tries.positive?
      run_game
      if check_winning_condition
        puts "🏆✨ You’ve won the game! ✨🏆"
        break
      end
    end
    puts @secret_word
    puts "👎🎭 You lost! Womp womp... 🎭👎" if @tries.zero?
  end

  def run_game
    display_update
    guess = @player.guess_word
    check_guess(guess)
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

  def display_update
    puts "#{@tries} tries remaining"
    puts "Your guesses so far: "
    puts @guess_history.join(" ")
    puts "Secret Word: "
    puts @blank_placeholders.join(" ")
  end

  def check_winning_condition
    @secret_word.eql?(@blank_placeholders.join)
  end

  def check_guess(guess)
    correct_guess = false

    @secret_word.each_char.with_index do |char, index|
      if char == guess
        @blank_placeholders[index] = guess
        correct_guess = true
      end
    end

    if correct_guess
      puts "Good guess!"
    else
      puts "Incorrect guess! Try again"
      @tries -= 1
    end

    @guess_history << guess
  end
end

require_relative "game_instructions"
require_relative "serializable"

# this file defines the game class logic
class Game # rubocop:disable Metrics/ClassLength
  include Serializable

  attr_accessor :player, :secret_word, :blank_placeholders, :guess_history, :tries, :first_game, :correct_guess

  def initialize(player)
    @player = player
    @secret_word = nil
    @blank_placeholders = nil
    @guess_history = []
    @tries = 6
    @game_state = :new
    @correct_guess = false
  end

  def load_words
    words = File.read(File.join(__dir__, "../words.txt")).strip.split
    @secret_word = words.filter { |word| word.size.between?(5, 12) }.sample
    @blank_placeholders = Array.new(@secret_word.size, "__")
  end

  def start_game
    load_words
    if @game_state == :new
      mode = load_game
      game_intro(mode)
    end
    play_rounds
    play_again?
  end

  def play_rounds
    while @tries.positive?
      run_game
      if check_winning_condition
        puts "🏆✨ You’ve won the game! ✨🏆"
        break
      end
    end
    puts "The Secret Word: #{@secret_word}"
    puts "👎🎭 You lost! Womp womp... 🎭👎" if @tries.zero?
  end

  def run_game
    save_game(:auto_save)
    display_update
    guess = @player.guess_word
    check_guess(guess)
  end

  def game_intro(mode)
    return unless mode == :new

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
    if @guess_history.include?(guess)
      puts "You've already guessed #{guess}. Try another one"
      return
    end

    update_blank_placeholder(guess)
    give_feedback
    @guess_history << guess
  end

  def update_blank_placeholder(guess)
    @correct_guess = false

    @secret_word.each_char.with_index do |char, index|
      if char == guess
        @blank_placeholders[index] = guess
        @correct_guess = true
      end
    end
  end

  def give_feedback
    if @correct_guess
      puts "Good guess!"
    else
      puts "Incorrect guess! Try again"
      @tries -= 1
    end
  end

  def reset_game
    @guess_history = []
    @tries = 6
    @game_state = :replay
  end

  def play_again?
    answer = @player.validate_player_answer
    if answer == "y"
      reset_game
      start_game
    else
      puts "Thanks for playing!"
      exit # Exits the program
    end
  end
end

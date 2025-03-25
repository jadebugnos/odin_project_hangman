require "json"
# this file defines the serializable module
module Serializable
  # converts the object into a JSON string
  # def to_json(*_options)
  #   {
  #     # Stores the name of the class to recreate the object during deserialization
  #     "json_class" => self.class.name,
  #     "player" => @player,
  #     "secret_word" => @secret_word,
  #     "blank_placeholders" => @blank_placeholders,
  #     "guess_history" => @guess_history,
  #     "tries" => @tries,
  #     "first_game" => @first_game,
  #     "correct_guess" => @correct_guess
  #   }.to_json
  # end
  def to_json(*args)
    {
      "json_class" => self.class.name, # Stores the class name
      "data" => instance_variables.to_h { |var| [var.to_s.delete("@"), instance_variable_get(var)] }
    }.to_json(*args)
  end

  def self.json_create(data)
    obj = new
    data["data"].each { |var, value| obj.instance_variable_set("@#{var}", value) }
    obj
  end

  # # Recreates the object from the JSON data
  # def self.json_create(data)
  #   # Dynamically gets the class name stored in "json_class" and calls .new on that class
  #   # Same as doing Game.new(...) but works dynamically for any class
  #   Object.const_get(data["json_class"]).new(
  #     data["player"],            # Player's name
  #     data["secret_word"],       # The secret word to guess
  #     data["blank_placeholders"], # The placeholders for guessed letters
  #     data["guess_history"],      # Array of past guesses
  #     data["tries"],              # Number of remaining tries
  #     data["first_game"],         # Boolean to indicate if it's the first game
  #     data["correct_guess"]       # Boolean to track if a correct guess was made
  #   )
  # end

  # handles save game progress
  def save_game
    save_file
    puts "progress saved successfully"
  end

  # writes the serialized game data to a file
  def save_file
    File.open("saved_game.json", "w") do |file|
      file.puts to_json # Converts object to JSON and writes it to the file
    end
  end

  # Handles the load game process
  def load_game
    if handle_validation("load") == "y"
      puts "Loading saved game progress..."
      load_file
    else
      puts "Creating new game..."
    end
  end

  def handle_validation(mode)
    answer = ""
    puts "do you want to #{mode} the game? y/n"
    loop do
      answer = gets.chomp.downcase

      raise "Invalid input! enter y or n" unless %w[y n].include?(answer)

      break
    rescue StandardError => e
      puts e.message
    end
    answer
  end

  # Retrieves and loads the saved game data
  def load_file
    if File.exist?("saved_game.json")
      # Reads the saved game state from the file
      data = File.read("saved_game.json")

      # Parses the JSON data and recreates the object using json_create
      # "create_additions: true" triggers json_create to recreate the object
      game_data = JSON.parse(data, create_additions: true)

      # Assigns the saved values back to instance variables
      @player = game_data["player"]
      @secret_word = game_data["secret_word"]
      @blank_placeholders = game_data["blank_placeholders"]
      @guess_history = game_data["guess_history"]
      @tries = game_data["tries"]
      @first_game = game_data["first_game"]
      @correct_guess = game_data["correct_guess"]
      puts "Game loaded successfully!"
    else
      puts "No saved game found."
    end
  end
end

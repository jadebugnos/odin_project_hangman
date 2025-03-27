require "json"

# This module adds serialization and deserialization capabilities to any class that includes it.
module Serializable
  # Converts an object to a JSON string.
  # It includes the class name and instance variables.
  def to_json(*args)
    {
      "json_class" => self.class.name, # Stores the class name for deserialization
      "data" => # Converts instance variables into a hash
instance_variables.to_h do |var|
  [var.to_s.delete("@"), instance_variable_get(var)]
end
    }.to_json(*args)
  end

  # When this module is included, extend the including class with class-level methods defined in ClassMethods.
  def self.included(base)
    base.extend(ClassMethods)
  end

  # Module containing class methods that will be added to the including class.
  module ClassMethods
    # Creates an object from JSON data.
    # Uses allocate to create an object without calling the initialize method.
    def json_create(data)
      obj = allocate
      data["data"].each do |var, value|
        # Set each instance variable with the corresponding value from the JSON data
        obj.instance_variable_set("@#{var}", value)
      end
      obj
    end
  end

  # Saves the current game state by writing its JSON representation to a file.
  def save_game(save_type)
    save_file
    case save_type
    when :auto_save
      puts "Automatic progress save successful."
    when :player_save
      puts "The game was saved successfully."
    end
  end

  # Writes the serialized game data to 'saved_game.json'.
  def save_file
    File.open("saved_game.json", "w") do |file|
      file.puts to_json # Converts the object to JSON and writes it to the file
    end
  end

  # Handles the load game process by checking with the user and restoring game state.
  def load_game
    if handle_validation("load") == "y"
      puts "Loading saved game progress..."
      restored_obj = load_file
      # Copy each instance variable from the restored object to self
      restored_obj.instance_variables.each do |var|
        instance_variable_set(var, restored_obj.instance_variable_get(var))
      end
      puts "Welcome back! Ready to pick up where we left off?"
      :load
    else
      puts "Creating new game..."
      :new
    end
  end

  # Asks the user for validation on a given mode (load or other).
  # Repeats until a valid response ("y" or "n") is given.
  def handle_validation(mode)
    answer = ""
    puts "do you want to #{mode} the game? y/n"
    loop do
      answer = gets.chomp.downcase
      # Raise an error if the input is not "y" or "n"
      raise "Invalid input! enter y or n" unless %w[y n].include?(answer)

      break
    rescue StandardError => e
      puts e.message
    end
    answer
  end

  # Loads the game state from 'saved_game.json' if it exists.
  # Uses JSON.parse with create_additions to restore the object using json_create.
  def load_file
    if File.exist?("saved_game.json")
      data = File.read("saved_game.json")
      restored_obj = JSON.parse(data, create_additions: true)
      puts "Game loaded successfully!"
      restored_obj # Return the restored object
    else
      puts "No saved game found."
      self # Return self if no saved file exists
    end
  end
end

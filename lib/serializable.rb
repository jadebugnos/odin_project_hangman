# this file defines the serializable module
module Serializable
  def to_json(*_options)
    {
      "json_class" => self.class.name,
      "player" => @player,
      "secret_word" => @secret_word,
      "blank_placeholders" => @blank_placeholders,
      "guess_history" => @guess_history,
      "tries" => @tries,
      "first_game" => @first_game,
      "correct_guess" => @correct_guess
    }.to_json
  end

  def self.json_create(data)
    Object.const_get(data["json_class"]).new(
      data["player"],
      data["secret_word"],
      data["blank_placeholders"],
      data["guess_history"],
      data["tries"],
      data["first_game"],
      data["correct_guess"]
    )
  end

  def save_game
    answer = ""
    puts "do you want to save the game? y/n"
    loop do
      answer = gets.chomp.downcase

      raise "Invalid input! enter y or n" unless %w[y n].include?(answer)

      break
    rescue StandardError => e
      puts e.message
    end
    if answer == "y"
      save_file
      puts "Game saved successfully!"
    else
      puts "Game not saved."
    end
  end

  def save_file
    File.open("saved_game.json", "w") do |file|
      file.puts to_json
    end
  end
end

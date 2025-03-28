# The Odin Project: Hangman (Ruby CLI)

This project is part of **The Odin Project** curriculum. Hangman is a fun and engaging command-line game where players attempt to guess a secret word, letter by letter, before running out of tries! The game also features **save and load** functionality using **Serialization**, allowing players to resume their progress anytime.

## 🎮 Game Overview
### In this game:
- A secret word is chosen randomly from a list by the computer.
- The player guesses letters to fill in the blanks.
- You win if you correctly guess the word before running out of tries.
- You can save and load the game to continue playing later.

## 📚 Features
- ✅ Word selection between 5 to 12 characters.
- ✅ Letter-by-letter guessing with feedback.
- ✅ Save and load functionality to preserve progress.
- ✅ Automatically saves the game after every round.
- ✅ Error handling for invalid inputs.
- ✅ Option to replay the game after winning or losing.

## 📦 Installation
### 1. Clone the repository
```sh
git clone git@github.com:jadebugnos/odin_project_hangman.git
cd odin_project_hangman
```

### 2. Install Ruby (if not already installed)
**Ensure you have Ruby installed on your system**
```sh
ruby -v
```
**if not, download and install it from [Ruby Downloads](https://www.ruby-lang.org/en/downloads/)

### 3. Install Bundler and Project Dependencies
```sh
gem install bundler
bundle install
```

## ▶️ Play The Game
```sh
ruby main.rb
```

## 🎮 Game Instructions

### Start the Game:
- The game will load the instructions and prompt for a new game or load a saved one.

### Guess a Letter:
- Type a letter and press Enter.
- Correct guesses will update the placeholders.
- Incorrect guesses will reduce the number of tries.

### Save the Game:
- Type `save` to save your progress at any point.

### Quit the Game:
- Type `exit` to quit without saving.

### Replay or Exit:
- After winning or losing, you can choose to play again.

## 💾 Save & Load Functionality

### Auto-Save:
- The game automatically saves progress after each guess.

### Manual Save:
- Type `save` to manually save the game.

### Load Game:
- When starting, you can choose to load a saved game.

## 🧩 Possible Improvements

- 🚀 Add difficulty levels (easy, medium, hard).
- 🔤 Add hints or clues for difficult words.
- 📜 Implement a leaderboard to track high scores.

## 📄 License
This project is licensed under the MIT License. See the [LICENSE](https://opensource.org/licenses/MIT) file for details.

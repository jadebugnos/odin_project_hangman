module GameInstructions
  INSTRUCTIONS = {
    intro: <<~TEXT
      ************************************
      🎯 WELCOME TO HANGMAN! 🎯
      ************************************

      Rules of the Game:
      - The computer has chosen a secret word.
      - You have to guess the word one letter at a time.
      - You get 6 chances to guess wrong before the man is hanged!
      - If you guess the word before running out of chances, you win! 🎉
      - If you fail, the word will be revealed at the end. 😢

      HOW TO PLAY:
      - Type a letter and press Enter.
      - If the letter is correct, it fills in the blanks.
      - If the letter is wrong, you lose a chance.
      - Try to guess the full word before you run out of chances!

      Are you ready? Let’s play! 🚀
    TEXT
  }.freeze
end

# Mastermind!
Mastermind is a classic code-breaking game implemented in Ruby using object-oriented programming (OOP) principles. It allows you to play against the computer or another player. The game prompts users for the number of rounds they would like to play and then allows them to select their roles.

**Features**
- Play against the computer or another player.
- Set the number of rounds to play.
- Interactive prompts and feedback.
- Role swapping between Code Maker and Code Breaker.
- Randomized secret code generation for the computer.
- Dynamic scoring system to keep track of points.

**How To Play**
- Clone the repository and navigate to the project directory.
- Make sure you have Ruby installed on your system.
- Run the following command in your terminal to start the game:
- Choose the number of rounds you want to play.
- Select your role as either the Code Maker or the Code Breaker.
- If you choose to be the Code Maker, you will set a secret code by picking four colors from an array of available colors.
- If you choose to be the Code Breaker, you will have 10 tries to guess the secret code set by the Code Maker.
- After each guess, the game will provide feedback on your guess, indicating if you have the correct colors and their correct positions or if you have the correct colors in the wrong positions.
- If you successfully guess the code within the allotted number of tries, you win the round and prevent the Code Maker from getting maximun points. Otherwise, the Code Maker wins the round with maximum points (11).
- After each round, the roles will be swapped, and the game will continue for the specified number of rounds.
- At the end of the game, the winner with the highest points will be declared.

**Acknowledgements**
- The Mastermind game was originally invented by Mordecai Meirowitz in 1970. This implementation in Ruby is created by Draco 3000.
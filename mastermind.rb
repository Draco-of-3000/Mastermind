class Players
    attr_accessor :name, :role
    def initialize (name, role)
        @name = name
        @role = role
    end
end

class Mastermind
    @@colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    @@human_code = []
    @@human_answer = " "
    @@number_of_guesses = 0
    @@code_maker_points = 1
    @@player_one_points = 1
    @@player_two_points = 1
    @@rounds = 3
    @@code_maker_code = []
    @@code_breaker_code = []
    @@player_one_code = []
    @@player_two_code = []
    @@current_player = " "
    @@code_maker_selection = []
    @@code_breaker_selection = []


    attr_accessor :cpu_code 
    def initialize
        @cpu_code = []
    end

    def cpu_selection
        @random_colors = @@colors.sample(4).map(&:downcase)
        @result = @random_colors
        return @result
    end
    
    def human_selection
        puts "Pick 4 colors out of #{@@colors} in any order you want to be your code"
        
        until @@human_code.size == 4
            @input = gets.chomp.downcase
            @@human_code.push(@input)
        end
        @@human_code
    end

    def cpu_code_maker
        puts "Welcome to Mastermind! You are the Code Breaker and the CPU is the Code Maker" + "\n" +
        "You have 10 tries to guess the write colors and their right positions" + "\n" +
        "The feedback will be 'white' for every color you get right but not in order!" + "\n" +
        "The feedback will be 'black' for every color you get right but not in order!" + "\n" +
        "The onus is on you to use this information to break the code" + "\n" +
        "Are you up to the task Code Breaker? type 'yes' to continue"

        until @@human_answer == 'yes'
            @answer = gets.chomp.downcase
            @@human_answer = @answer
        end

        @cpu_code = cpu_selection
        
        cpu_code_maker_game_loop
    end

    def human_code_maker
        if @player_one.role == 'maker'
            @code_maker_selection = player_one_selection
            @code_breaker_selection = player_two_selection
            @@player_one_points = @@code_maker_points 
        elsif @player_two.role == 'maker'
            @code_maker_selection = player_two_selection
            @code_breaker_selection = player_one_selection
            @@player_two_points = @@code_maker_points
        end
        
        until @@number_of_guesses == 5 || @@code_breaker_code == @@code_maker_code
            @@code_breaker_code.clear

            human_code_breaker

            @@code_maker_code.each_with_index do |color, index|
                if @@code_breaker_code[index] == color
                  puts correct_feedback
                elsif @@code_breaker_code.include?(color)
                  puts mid_feedback
                else
                  puts wrong_feedback
                end
            end
            count_code_maker_points
            count_guess
            assign_points
            declare_winner_after_round
            swap_roles
        end
    end

    def human_code_breaker
        if @player_one.role == 'breaker'
            @code_breaker_selection = player_one_selection
            @code_maker_selection = player_two_selection
            @@player_one_points = @@code_maker_points
        elsif player_two.role == 'maker'
            @code_breaker_selection = player_two_selection
            @code_maker_selection = player_one_selection
            @@player_two_points = @@code_maker_points
        end
        @code_breaker_selection
    end

    def code_maker_score
        puts "Code Maker score = #{@@code_maker_points} points"
    end

    def player_code_maker_score
        if @player_one.role == 'maker'
            puts @@player_one_points
        elsif @player_two.role == 'maker'
            puts @@player_two_points
        end
    end

    def cpu_code_breaker
        puts "Welcome to Mastermind! You are the Code Maker and the CPU is the Code Breaker" + "\n" +
        "The CPU has 10 tries to guess the right colors and their right positions" + "\n" +
        "The onus is on you to come up with an unbreakable code" + "\n" +
        "Are you up to the task Code Maker? type 'yes' to continue"

        until @@human_answer == 'yes'
            @answer = gets.chomp.downcase
            @@human_answer = @answer
        end

        human_selection

        until @@number_of_guesses == 5 || @cpu_code == @@human_code
            cpu_selection

            puts code_maker_score

            puts "Code Breaker's guess = #{cpu_selection}"
            count_code_maker_points
            count_guess
            declare_winner_as_code_maker
            puts code_maker_score
        end 

    end

    def play_game
        @@rounds.times do |round|
          puts "Round #{round + 1} starts now"

          reset_variables
          
          player_vs_player
        end
    end

    def reset_variables
        @@number_of_guesses = 0
        @@code_breaker_code = []
        @@human_answer = " "
        @@code_maker_code = []
        @@player_one_code = []
        @@player_two_code = []
    end

    def player_vs_player
        puts "Welcome to Mastermind!\nType 'yes' to continue"
      
        until @@human_answer == 'yes'
          @answer = gets.chomp.downcase
          @@human_answer = @answer
        end
      
        player_one_selection
      
        until @@number_of_guesses == 5 || @@code_breaker_code == @@code_maker_code 
            @@code_breaker_code.clear

            player_two_selection

            puts player_code_maker_score

            @@code_breaker_code.each_with_index do |color, index|
                if @@code_maker_code[index] == color
                  puts correct_feedback
                elsif @@code_maker_code.include?(color)
                  puts mid_feedback
                else
                  puts wrong_feedback
                end
            end
            count_code_maker_points
            count_guess
        end
        swap_roles
    end
      

    def get_player_names
        puts "Welcome to Mastermind"
        puts "Player 1, please enter your name"
        @player1_name = gets.chomp
        @player1_role = 'maker'
        @player_one = Players.new(@player1_name, @player1_role)

        puts "Player 2, please enter your name"
        @player2_name = gets.chomp
        @player2_role = 'breaker'
        @player_two = Players.new(@player2_name, @player2_role)

        play_game
    end

    def player_one_selection
        puts "Pick 4 colors out of #{@@colors} in any order you want to be your code"
        
        until @@player_one_code.size == 4
            @input = gets.chomp.downcase
            @@player_one_code.push(@input)
            @@code_maker_code = @@player_one_code
        end
        @@code_maker_code
    end

    def player_two_selection
        puts "Attempt to break the code by picking 4 colors out of #{@@colors} in any order"
        
        until @@player_two_code.size == 4
            @input = gets.chomp.downcase
            @@player_two_code.push(@input)
            @@code_breaker_code = @@player_two_code
        end
        @@code_breaker_code
    end

    def get_number_of_games
        puts "How many rounds do you want to play?"
        @@rounds = nil

        until @@rounds.is_a?(Integer) && @@rounds > 0
            puts "Enter a positive integer: "
            input = gets.chomp

            if input.match?(/\A\d+\z/)
                @@rounds = input.to_i
            else
                puts "Invalid input. Please enter a valid number."
            end 
        end
        @@rounds
    end

    def cpu_code_maker_game_loop
        until @@number_of_guesses == 5 || @@human_code == @cpu_code
            @@human_code.clear

            human_selection

            puts code_maker_score

            @@human_code.each_with_index do |color, index|
                if @cpu_code[index] == color
                  puts correct_feedback
                elsif @cpu_code.include?(color)
                  puts mid_feedback
                else
                  puts wrong_feedback
                end
            end
            count_code_maker_points
            count_guess
            declare_winner_as_code_breaker
        end 
    end

    def count_guess
        @@number_of_guesses += 1
        @@number_of_guesses
    end

    def wrong_feedback
        return "null"
    end

    def mid_feedback
        return "white"
    end

    def correct_feedback
        return "black"
    end

    def count_code_maker_points
        @@code_maker_points += 1
        @@code_maker_points
    end

    def assign_points
        if @@number_of_guesses == 5 || @code_breaker_code == @code_maker_code && @player_one.role == 'maker'
            @@player_one_points = "#{@player1_name} points: #{@code_maker_points}"
        elsif @@number_of_guesses == 5 || @code_breaker_code == @code_maker_code && @player_two.role == 'maker'
            @@player_two_points = "#{@player2_name} points: #{@code_maker_points}"
        end
    end

    def swap_roles
        puts "Time to switch!"
        if @@number_of_guesses == 5 || @@code_breaker_code == @@code_maker_code
          temp_selection = player_one_selection
      
          @@code_maker_code = player_two_selection
          @@code_breaker_code = temp_selection
        end

        
        if @player_one.role == 'maker'
            code_maker_name = @player2_name
            code_breaker_name = @player1_name
          elsif @player_two.role == 'maker'
            code_maker_name = @player1_name
            code_breaker_name = @player2_name
        end
        
        if code_maker_name && code_breaker_name
            puts "#{code_maker_name} is the code maker now"
            puts "#{code_breaker_name}, can you break #{code_maker_name}'s code?"
        end
    end
      
    def new_game

    end

    def declare_winner_after_round
        if @@code_breaker_code == @@code_maker_code && @player_one.role == 'maker'
            puts "#{@player2_name} wins this round!"
        elsif @@number_of_guesses == 5 && @@code_breaker_code != @@code_maker_code && @player_one.role == 'maker'
            puts "#{@player1_name} wins this round!"
        elsif @@code_breaker_code == @@code_maker_code && @player_two.role == 'maker'
            puts "#{@player1_name} wins this round!"
        elsif @@number_of_guesses == 5 && @@code_breaker_code != @@code_maker_code && @player_two.role == 'maker'
            puts "#{@player2_name} wins this round!"
        end
    end

    def declare_winner_after_game_over
        if @@rounds == 0 && @@player_one_points > @@player_two_points
            puts "#{@player1_name} has won the game!"
        elsif @@rounds == 0 && @@player_two_points > @@player_one_points
            puts "#{@player2_name} has won the game!"
        end
    end

    def reveal_cpu_answer
        puts "Code Maker's code was #{@cpu_code}"
    end

    def declare_winner_as_code_breaker
        if @@number_of_guesses == 5 && @@human_code != @cpu_code
            puts "In colors concealed, code remains unbroken," + "\n" +
            "Failure lingers, better luck next time Code Breaker"
            count_code_maker_points
        elsif @@human_code == @cpu_code
            puts "Victorious! The code succumbs to your might," + "\n" +
            "In colors aligned, mastery shines bright." "\n" +
            "Congratulations, Code Breaker, for your grand win!"
        end

        reveal_cpu_answer
    end

    def declare_winner_as_code_maker
        if @@number_of_guesses == 5 && @cpu_code != @@human_code
            puts "In colors concealed, your code remains unbroken," + "\n" +
            "Victorious you are! Code Maker!"
        elsif @cpu_code == @@human_code
            puts "From the depths of your code's demise,," + "\n" +
            "The Breaker emerges, victorious and wise." "\n" +
            "Better luck next time, O' Maestro of Deception."
        end
    end
end

game = Mastermind.new
game.get_player_names
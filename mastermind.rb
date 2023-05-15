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
    @@rounds = nil
    @@code_maker_code = []
    @@code_breaker_code = []
    @@player_one_code = []
    @@player_two_code = []
    @@current_player = " "

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

    def code_maker_score
        puts "Code Maker score = #{@@code_maker_points} points"
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

    def get_player_names
        puts "Welcome to Mastermind"
        puts "Player 1, please enter your name"
        @player1_name = gets.chomp
        puts "Would you like to be Code Maker or Code Breaker, type 'Maker' or 'Breaker'"
        @player1_role = gets.chomp.downcase

        until @player1_role == 'maker' || 'breaker'
            puts "Invalid input, type 'Maker' or 'Breaker'"
            @player1_role = gets.chomp.downcase
        end

        player_one = Players.new(@player1_name, @player1_role)

        puts "Player 2, please enter your name"
        @player2_name = gets.chomp
        @player2_role = player_one.role == 'maker' ? 'breaker' : 'maker'
        player_two = Players.new(@player2_name, @player2_role)
    end

    def player_one_selection
        puts "Pick 4 colors out of #{@@colors} in any order you want to be your code"
        
        until @@player_one_code.size == 4
            @input = gets.chomp.downcase
            @@player_one_code.push(@input)
        end
        @@player_one_code
    end

    def player_two_selection
        puts "Pick 4 colors out of #{@@colors} in any order you want to be your code"
        
        until @@player_two_code.size == 4
            @input = gets.chomp.downcase
            @@player_two_code.push(@input)
        end
        @@player_two_code
    end

    def get_number_of_games
        puts "How many rounds do you want to play?"
        @@rounds = nil

        until @@rounds.is_a?(Integer) && number > 0
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
        if @@number_of_guesses == 5 || @code_breaker_code == @code_maker_code && player_one.role == 'maker'
            @@player_one_points = @code_maker_points
        elsif @@number_of_guesses == 5 || @code_breaker_code == @code_maker_code && player_two.role == 'maker'
            @@player_two_points = @code_maker_points
        end
    end

    def swap_roles
        @@current_player = @current_player == 'maker' ? 'breaker' : 'maker'
    end

    def new_game

    end

    def declare_winner_after_round
        if @@code_breaker_code == @code_maker_code && player_one.role == 'maker'
            puts "#{@player2_name} wins this round!"
        elsif @@number_of_guesses == 5 && @code_breaker_code != @code_maker_code && player_one.role == 'maker'
            puts "#{@player1_name} wins this round!"
        elsif @@code_breaker_code == @code_maker_code && player_two.role == 'maker'
            puts "#{@player1_name} wins this round!"
        elsif @@number_of_guesses == 5 && @code_breaker_code != @code_maker_code && player_two.role == 'maker'
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
puts game.cpu_code_breaker
class Mastermind
    @@colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    @@human_code = []
    @@human_answer = " "
    @@number_of_guesses = 0
    @@code_maker_points = 1
    @@rounds = 4
    @@code_maker_code = []
    @@code_breaker_code = []
    @@code_maker_selection = []
    @@code_breaker_selection = []
    @@cpu_previous_guesses = []
    @@feedbacks = []
    @@user_round = " "

    attr_accessor :cpu_code 
    def initialize
        @cpu_code = []
        @player_points = {}
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

            if @@human_code.include?(@input)
                puts "You have already selected #{@input}. Choose a different color."
            elsif !@@colors.map(&:downcase).include?(@input)
                puts "Invalid Selection, please select colors from #{@@colors}"
            else
                @@human_code.push(@input)
            end
        end
        @@human_code
    end

    def cpu_code_maker
        line_seperator

        puts "Welcome to Player vs CPU! You are the Code Breaker and the CPU is the Code Maker" + "\n" +
        "You have 10 tries to guess the right colors and their right positions" + "\n" +
        "The feedback will be 'white' for every color you get right but not in order!" + "\n" +
        "The feedback will be 'black' for every color you get right but not in order!" + "\n" +
        "The feedback will be 'null' for every wrong color but not in order!" + "\n" +
        "The onus is on you to use this information to break the code" + "\n" +
        "Are you up to the task Code Breaker? \n Type 'yes' to continue"

        line_seperator

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
        line_seperator
        puts "Welcome to Player vs CPU! You are the Code Maker and the CPU is the Code Breaker" + "\n" +
        "The CPU has 10 tries to guess the right colors and their right positions" + "\n" +
        "The onus is on you to come up with an unbreakable code" + "\n" +
        "Are you up to the task Code Maker? \n Type 'yes' to continue"
        line_seperator
        
        until @@human_answer == 'yes'
            @answer = gets.chomp.downcase
            @@human_answer = @answer
        end

        human_selection
        @cpu_code = cpu_selection

        until @@number_of_guesses == 10 || @cpu_code == @@human_code
            cpu_selection

            line_seperator
            puts code_maker_score

            puts "\n" "Feedback\n"
            line_seperator
            generate_feedback_for_cpu
            line_seperator

            puts "Code Breaker's guess = #{cpu_selection}"
            line_seperator

            count_code_maker_points
            count_guess
            declare_winner_as_code_maker
            puts code_maker_score
            line_seperator
        end 

    end

    def generate_feedback_for_cpu
        feedback = []

        @cpu_code.each_with_index do |color, index|
            if @@human_code[index] == color
              feedback << correct_feedback
            elsif @@human_code.include?(color)
              feedback << mid_feedback
            else
              feedback << wrong_feedback
            end
        end
        puts feedback
    end

    def play_game
        round = 1
        until @@rounds == 0
          line_seperator
          puts "Round #{round} starts now"
          line_seperator

          reset_variables
          
          player_vs_player
          round += 1
          @@rounds -= 1
        end
        if @@rounds == 0
            declare_winner_after_game_over
        end
    end

    def reset_variables
        @@number_of_guesses = 0
        @@code_breaker_code = []
        @@human_answer = " "
        @@code_maker_code = []
        @@code_maker_points = 0
    end

    def player_vs_player
        puts "Type yes to continue"

        until @@human_answer == 'yes'
          @answer = gets.chomp.downcase
          @@human_answer = @answer
        end
      
        code_maker_selection if @code_maker
      
        until game_over 
            @@code_breaker_code.clear

            code_breaker_selection if @code_breaker

            puts "\n" "Feedback\n"
            line_seperator

            randomized_feedback
            count_guess
            assign_points
            line_seperator
            puts current_code_maker_score
            puts guesses_left
            line_seperator
            declare_winner_after_round if @@rounds > 1
            line_seperator

            swap_roles if game_over && @@rounds > 1
        end
    end
      
    def get_player_names_and_roles
        roles = ["maker", "breaker"]
      
        players = []
      
        puts "Enter your name Player 1:"
        player_name = gets.chomp
      
        puts "Available roles: maker, breaker"
        puts "#{player_name}, enter your role"
        player_role = gets.chomp.downcase
      
        until roles.include?(player_role)
          puts "Invalid role! Available roles: maker, breaker"
          puts "#{player_name}, enter your role"
          player_role = gets.chomp.downcase
        end
      
        players << [player_name, player_role]
        assign_player_roles(player_name, player_role)
      
        puts "Enter your name Player 2:"
        player_name = gets.chomp
      
        # Automatically assign the remaining role to the second player
        player_role = roles.find { |role| role != players[0][1] }
        players << [player_name, player_role]
        assign_player_roles(player_name, player_role)
      
        line_seperator
      
        get_number_of_games
        play_game
    end
      
    def assign_player_roles(player_name, player_role)
        if player_role == "maker"
            @code_maker = player_name
        elsif player_role == "breaker"
            @code_breaker = player_name
        end
    end

    def count_player_code_maker_points
        @player_points[@code_maker] ||= 0
        @player_points[@code_maker] += 1
        if @@number_of_guesses == 5 && @@code_breaker_code != @@code_maker_code
            @player_points[@code_maker] += 1
        end
    end

    def current_code_maker_score
        if @code_maker
            code_maker_score = @player_points[@code_maker] || 0
            puts "#{@code_maker} score: #{code_maker_score}"
        end
    end

    def guesses_left
        "Number of guesses made: #{@@number_of_guesses}"
    end

    def code_maker_selection
        puts "Pick 4 colors out of #{@@colors} in any order you want to be your code"

        @input = []

        until @@code_maker_code.size == 4
            @input = gets.chomp.downcase

            if @@code_maker_code.include?(@input)
                puts "You have already selected #{@input}. Choose a different color."
            elsif !@@colors.map(&:downcase).include?(@input)
                puts "Invalid Selection, please select colors from #{@@colors}"
            else
                @@code_maker_code.push(@input)
            end
        end
        @@code_maker_code
        line_seperator
    end

    def code_breaker_selection
        puts "Attempt to break the code by picking 4 colors out of #{@@colors} in any order"
        
        until @@code_breaker_code.size == 4
            @input = gets.chomp.downcase
            @@code_breaker_code.push(@input)
        end
        @@code_breaker_code
    end

    def game_over
        @@number_of_guesses == 10 || @@code_breaker_code == @@code_maker_code
    end

    def get_number_of_games
        puts "How many rounds do you want to play?"
        @@rounds = nil

        until @@rounds.is_a?(Integer) && @@rounds > 0 && @@rounds.even?
            puts "Enter a positive even integer: "
            input = gets.chomp

            if input.match?(/\A\d+\z/)
                @@rounds = input.to_i
          
                unless @@rounds.even?
                  puts "Invalid input. Please enter an even number."
                end
            else
                puts "Invalid input. Please enter a valid number."
            end
        end
        @@user_round = @@rounds
        @@rounds
    end

    def cpu_code_maker_game_loop
        until @@number_of_guesses == 10 || @@human_code == @cpu_code
            @@human_code.clear

            human_selection

            line_seperator

            puts code_maker_score

            puts "\n" "Feedback\n"
            line_seperator

            randomized_feedback_vs_cpu

            line_seperator
            count_code_maker_points
            count_guess
            declare_winner_as_code_breaker
            line_seperator
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

    def randomized_feedback_vs_cpu
        feedback = []

        @@human_code.each_with_index do |color, index|
            if @cpu_code[index] == color
              feedback << correct_feedback
            elsif @cpu_code.include?(color)
              feedback << mid_feedback
            else
              feedback << wrong_feedback
            end
        end

        feedback.shuffle!

        puts feedback
    end

    def randomized_feedback
        feedback = []

        @@code_breaker_code.each_with_index do |color, index|
            if @@code_maker_code[index] == color
              feedback << correct_feedback
            elsif @@code_maker_code.include?(color)
              feedback << mid_feedback
            else
              feedback << wrong_feedback
            end
        end

        feedback.shuffle!

        puts feedback
    end

    def count_code_maker_points
        @@code_maker_points += 1
        @@code_maker_points
    end

    def assign_points
        if @code_maker
            count_player_code_maker_points
        end
    end
      
    def swap_roles
        if @code_maker && @code_breaker
            previous_code_maker = @code_maker
            previous_code_maker_points = @player_points[previous_code_maker] || 0

            @code_maker, @code_breaker = @code_breaker, @code_maker

            @player_points[@code_maker] ||= 0
            current_code_maker_points = @player_points[@code_maker]
 
            puts "#{@code_maker} is the code maker now"
            puts "#{@code_breaker}, can you break #{@code_maker}'s code?"
            puts "#{@code_maker} points: #{current_code_maker_points}"
        end
    end
      
    def declare_winner_after_round
        if @@code_breaker_code == @@code_maker_code 
            puts "#{@code_breaker} is victorious! The code succumbs to your might," + "\n" +
            "In colors aligned, mastery shines bright." "\n" +
            "Congratulations, #{@code_breaker}, for breaking the code!"
        elsif @@number_of_guesses == 5 && @@code_breaker_code != @@code_maker_code
            puts "In colors concealed, #{@code_maker}'s code remains unbroken," + "\n" +
            "Failure lingers, better luck next time #{@code_breaker}"
        end
    end
      
    def declare_winner_after_game_over
        if @@user_round == 1 && @@code_breaker_code == @@code_maker_code
            puts "GAME OVER!"
            puts "#{@code_breaker} broke the code and won the game!"
        else
            max_points = @player_points.values.max
            winner = @player_points.select { |player, points| points == max_points }.keys
            min_points = @player_points.values.min 
            loser = @player_points.select { |player, points| points == min_points }.keys
              
            if winner.length == 1 && winner != loser
                puts "GAME OVER!"
                puts "#{winner[0]} wins the game with #{max_points} point(s)!"
                puts "#{loser[0]} loses the game with #{min_points} point(s)!"
            elsif winner.length == 1 && winner == loser
                puts "GAME OVER!"
                puts "#{winner[0]} wins the game with #{max_points} point(s)!"
            else
                puts "It's a tie!"
            end
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

    def line_seperator
        puts "-----+-----+-----"
    end

    def start_game
        puts "Do you want to play against the cpu or another human player? \n Type cpu or player"
        @input = gets.chomp.downcase

        if @input == 'cpu'
            puts "Do you want to be Code Breaker or Code Maker \n Type maker or breaker "
            role = gets.chomp.downcase
            if role == 'maker'
                cpu_code_breaker
            elsif role == 'breaker'
                cpu_code_maker
            end
        elsif @input == 'player'
            line_seperator
            puts "You have chosen Player vs Player! " + "\n" +
            "Players start of by selecting a Code Breaker or Code Maker role" + "\n" +
            "The Code Maker sets a code" "\n" +
            "The Code Breaker has 10 tries to guess the right colors and their right positions" + "\n" +
            "The feedback will be 'white' for every color you get right but not in order!" + "\n" +
            "The feedback will be 'black' for every color you get right but not in order!" + "\n" +
            "The feedback will be 'null' for every wrong color but not in order!" + "\n" +
            "The onus is on you to use this information to outwit the other player" + "\n" +
            "Are you up to the task dear player?"
            line_seperator
            
            get_player_names_and_roles
        end
    end

end

game = Mastermind.new
game.start_game
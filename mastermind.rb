class Mastermind
    @@colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    @@human_code = []
    @@human_answer = " "
    @@number_of_guesses = 0
    @@code_maker_points = 1

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
        
        game_loop
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

    end

    def get_player_names

    end

    def get_number_of_games

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
            declare_winner_vs_cpu
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

    end

    def swap_roles

    end

    def new_game

    end

    def declare_winner

    end

    def reveal_cpu_answer
        puts "Code Maker's code was #{@cpu_code}"
    end

    def declare_winner_vs_cpu
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
end

game = Mastermind.new
puts game.cpu_code_maker
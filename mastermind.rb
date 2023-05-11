class Mastermind
    @@colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    @@cpu_code = " "
    @@human_code = []
    @@cpu_points = 0
    @@human_answer = " "
    @@number_of_guesses = 0
    @@code_maker_points = 0

    def cpu_selection
        @random_colors = @@colors.sample(4).map(&:downcase)
        @@cpu_code = @random_colors
        return @@cpu_code
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

        cpu_selection
        
        until @@number_of_guesses == 10 || @@human_code == @@cpu_code
            @@human_code.clear

            human_selection

            puts @@cpu_points

            @@human_code.each_with_index do |color, index|
                if @@cpu_code.include?(color)
                    puts mid_feedback
                elsif @@cpu_code[index] == color
                    puts correct_feedback
                else
                    puts wrong_feedback
                end
            end
            count_cpu_points
            count_guess
        end 

    end

    def cpu_code_breaker

    end

    def get_player_names

    end

    def get_number_of_games

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

    def count_cpu_points
        @@cpu_points += 1
        @@cpu_points
    end

    def assign_points

    end

    def swap_roles

    end

    def new_game

    end

    def declare_winner

    end
end

game = Mastermind.new
puts game.cpu_code_maker
class Mastermind
    @@Colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    @@cpu_code = " "
    def cpu_selection
        @random_colors = @@Colors.sample(4).map(&:downcase)
        @@cpu_code = @random_colors
        return @@cpu_code
    end
    
    def cpu_code_maker
        
    end

    def cpu_code_breaker

    end

    def get_player_names

    end

    def get_number_of_games

    end

    def count_guess

    end

    def wrong_feedback

    end

    def mid_feedback

    end

    def correct_feedback

    end

    def count_points

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
puts game.cpu_selection
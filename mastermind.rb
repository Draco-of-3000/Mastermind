class Mastermind
    @@Colors = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Brown","Pink"]
    
    def random_selection
        @random_colors = @@Colors.sample(4).map(&:downcase)
        return @random_colors
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
puts game.random_selection
require_relative 'util'

class RandomPlayer

    def initialize
        # TODO: Include whatever structure represents the player's memory
    end

    def create_guess(males, females)
        # puts "\t- Creating guess..."
        random_pair(males, females);
    end

    def guess_feedback(pair, is_correct)
        # puts "\t- Guess was #{is_correct ? "correct!" : "incorrect!"}"
        # TODO: store some info that'll be helpful
    end

    def create_lineup(males, females)
        # puts "\t- Creating lineup..."
        random_pairings(males, females)
    end

    def lineup_feedback(lineup, num_correct)
        # puts "\t- Number correct: #{num_correct}"
        # TODO: store some info that'll be helpful
    end

end

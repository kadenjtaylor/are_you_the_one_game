require 'ostruct'
require_relative 'src/random_player'
require_relative 'src/dumb_player'
require_relative 'src/util'
require_relative 'src/game'

def avg(counts)
    counts.sum(0.0) / counts.length
end

def conduct_trial(num_trials, males, females, player_classes, max_rounds)
    player_classes.each do |player_class|
        puts "-----------------------------------------------------------------"
        puts "Parameters:"
        puts "   - player_class: #{player_class}"
        puts "   - max_rounds: #{max_rounds}"
        puts

        # setup counters
        num_wins = 0
        turn_counts = []
        dumps_per_player = {}

        # run the tests
        num_trials.times {
            p = player_class.new
            g = Game.new(males, females, p, max_rounds)
            g.play_out
            if g.win?
                num_wins += 1
                turn_counts.append(g.turn_number)
                dumps_per_player[p] = p.dump_data
            end
        }

        # print the results
        puts "Summary:"
        puts "   - Games Played: #{num_trials}"
        puts "   - Games Won: #{num_wins}"
        puts "   - Avg Turns to Win: #{avg(turn_counts)}"
        puts "-----------------------------------------------------------------"
    end
end

# We start with 10 males and 10 females
males = %w(Adam Scali Dre Ryan Ethan Dillan Chris_T John Wes Joey)
females = %w(Shanley Paige Kayla Amber Jessica Jacy Simone Ashleigh Colyseah Brittany)

conduct_trial(100, males, females, [RandomPlayer, DumbPlayer], 60)


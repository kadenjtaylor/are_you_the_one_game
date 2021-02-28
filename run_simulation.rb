require 'ostruct'
require_relative 'src/random_player'
require_relative 'src/dumb_player'
require_relative 'src/util'
require_relative 'src/game'

# We start with 10 males and 10 females
males = %w(Adam Scali Dre Ryan Ethan Dillan Chris_T John Wes Joey)
females = %w(Shanley Paige Kayla Amber Jessica Jacy Simone Ashleigh Colyseah Brittany)

num_wins = 0
num_trials = 1

num_trials.times {
    g = Game.new(males, females, DumbPlayer.new)
    g.play_out
    if g.win?
        num_wins += 1
        puts "THEY GOT ONE!"
    end
}

puts "-----------------------------------------------------------------"
puts "Summary:"
puts "   - Games Played: #{num_trials}"
puts "   - Games Won: #{num_wins}"
# puts "   - Win Rate: #{num_wins/num_trials}"
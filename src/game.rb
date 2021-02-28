require 'ostruct'
require_relative 'random_player'
require_relative 'util'

class Game

    def initialize(males, females, player)
        if males.size != females.size
            throw new Error("Group size mismatch!")
        end
        @threshold = males.size # how many good correct_pairs we need to win
        @correct_pairs = random_pairings(males, females)
        @males = Array.new(males)
        @females = Array.new(females)
        @player = player
        @last_lineup_correct = 0
        @turns_left = 10
        @is_win = false
        @is_over = false
    end

    def is_guess_correct(player_guess)
        @correct_pairs.include? player_guess
    end

    def count_correct_in_lineup(player_lineup)
        count = 0
        player_lineup.each do |p|
            count += 1 if @correct_pairs.include? p
        end
        @last_lineup_correct = count
        count
    end

    def one_round

        puts "-----------------------------------------------------------------"
        puts "Turn #{11-@turns_left}: "

        # Step One: Guess a Pair
        player_guess = @player.create_guess(@males, @females)
        correct = @correct_pairs.include? player_guess
        @player.guess_feedback(player_guess, correct)

        # Step Two: Try a Lineup
        player_lineup = @player.create_lineup(@males, @females)
        num_correct = count_correct_in_lineup(player_lineup)
        @player.lineup_feedback(player_lineup, num_correct)

        @turns_left -= 1
        
        # Tie goes to the player
        if num_correct == @threshold
            # puts "[ Player WINS! ]"
            @is_win = true
            @is_over = true
        end

        # If we haven't won by the end of the last turn, we lose
        if @turns_left == 0
            # puts "[ Player loses...] "
            @is_win = false
            @is_over = true
        end
    end

    def is_over
        return @is_over
    end

    def win?
        @is_win
    end

    def last_lineup_correct
        @last_lineup_correct
    end

    def play_out
        # returns true iff player wins
        while !is_over
            one_round
        end
    end

end
require 'ostruct'

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
        @turns_left = 10
        puts "The game has begun! You have #{@turns_left} guesses.\n"
    end

    def is_guess_correct(player_guess)
        @correct_pairs.include? player_guess
    end

    def count_correct_in_lineup(player_lineup)
        count = 0
        player_lineup.each do |p|
            count += 1 if @correct_pairs.include? p
        end
        count
    end

    def one_round

        puts "Turn #{@turns_left}: "

        # Step One: Guess a Pair
        player_guess = @player.create_guess(@males, @females)
        correct = @correct_pairs.include? player_guess
        @player.guess_feedback(player_guess, correct)

        # Step Two: Try a Lineup
        player_lineup = @player.create_lineup(@males, @females)
        num_correct = count_correct_in_lineup(player_lineup)
        @player.lineup_feedback(player_lineup, num_correct)

        @turns_left -= 1
        if @turns_left <= 0
            player_loses && exit
        elsif num_correct == @threshold
            player_wins && exit
        end
    end

    def player_wins
        puts "The cast gets to split $1,000,000!"
    end

    def player_loses
        puts "The cast goes home with nothing..."
    end

    def is_over
        @turns_left <= 0
    end

end

class Player

    def create_guess(males, females)
        puts "\t- Creating guess..."
        # randomly grab one male and one female
        m = males.sample
        f = females.sample

        # create a pair out of them
        OpenStruct.new(
            :male => m,
            :female => f
        )
    end

    def create_lineup(males, females)
        puts "\t- Creating lineup..."
        random_pairings(males, females)
    end

    def guess_feedback(pair, is_correct)
        puts "\t- Guess was #{is_correct ? "correct!" : "incorrect!"}"
        # TODO: store some info that'll be helpful
    end

    def lineup_feedback(lineup, num_correct)
        puts "\t- Number correct: #{num_correct}"
        # TODO: store some info that'll be helpful
    end

end

def random_pairings(males, females)
    ms = Array.new(males)
    fs = Array.new(females)
    correct_pairs = Array.new
    while !ms.empty? # just run it until we run out of males

        # randomly grab one male and one female
        m = ms.sample
        f = fs.sample

        # remove them so we can't pick them twice
        ms.delete(m)
        fs.delete(f)

        # create a pair out of them
        correct_pairs.append(
            OpenStruct.new(
            :male => m,
            :female => f
        ))
    end
    correct_pairs
end

# We start with 10 males and 10 females
males = %w(Adam Scali Dre Ryan Ethan Dillan Chris_T John Wes Joey)
females = %w(Shanley Paige Kayla Amber Jessica Jacy Simone Ashleigh Colyseah Brittany)

g = Game.new(males, females, Player.new)
while !g.is_over
    g.one_round()
end

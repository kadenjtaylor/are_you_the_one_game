require 'ostruct'

class Game

    def initialize(males, females, player)
        if males.size != females.size
            throw new Error("Group size mismatch!")
        end
        @threshold = males.size # how many good pairs we need to win
        init_pairs(males, females)
        @males = Array.new(males)
        @females = Array.new(females)
        @player = player
        @good_pairs = []
        @bad_pairs = []
        @guesses_left = 10
        puts "The game has begun! You have #{@guesses_left} guesses.\n"
    end

    def init_pairs(males, females)
        ms = Array.new(males)
        fs = Array.new(females)
        @pairs = Array.new
        while !ms.empty? # just run it until we run out of males
    
            # randomly grab one male and one female
            m = ms.sample
            f = fs.sample

            # remove them so we can't pick them twice
            ms.delete(m)
            fs.delete(f)
    
            # create a pair out of them
            @pairs.append(
                OpenStruct.new(
                :male => m,
                :female => f
            ))
        end
    end

    def guess(pair)
        correct = @pairs.include? pair
        puts "You guessed: (#{pair.male} + #{pair.female}) => #{correct ? "GOOD" : "BAD"}"
        if correct
            @good_pairs.append(pair)
            puts "\t- Added (#{pair.male} + #{pair.female}) to good_pairs"
            puts "\t- Good Pairs: #{@good_pairs.size}"
            # TODO: This also gives us information about other bad pairs
        elsif
            @bad_pairs.append(pair)
            puts "\t- Added (#{pair.male} + #{pair.female}) to bad_pairs"
            puts "\t- Bad Pairs: #{@bad_pairs.size}"
        end
        @guesses_left -= 1
        puts "\t- You have #{@guesses_left} guesses left."
        if @guesses_left <= 0
            player_loses && exit
        elsif @good_pairs.size == @threshold
            player_wins && exit
        end
        correct
    end

    def one_round
        player_guess = @player.create_guess(
            @good_pairs, @bad_pairs, @males, @females
        )
        guess(player_guess)
        player_lineup = @player.create_lineup(
            @good_pairs, @bad_pairs, @males, @females
        )
        judge_lineup(player_lineup)
    end

    def player_wins
        puts "The cast gets to split $1,000,000!"
    end

    def player_loses
        puts "The cast goes home with nothing..."
    end

    def is_over
        @guesses_left <= 0 or @good_pairs.size >= @threshold
    end

end

class Player

    def create_guess(good_pairs, bad_pairs, males, females)
        # TODO: Do something better than random!
        # randomly grab one male and one female
        m = males.sample
        f = females.sample

        # create a pair out of them
        OpenStruct.new(
            :male => m,
            :female => f
        )
    end

end

# We start with 10 males and 10 females
males = %w(Adam Scali Dre Ryan Ethan Dillan Chris_T John Wes Joey)
females = %w(Shanley Paige Kayla Amber Jessica Jacy Simone Ashleigh Colyseah Brittany)

g = Game.new(males, females, Player.new)
while !g.is_over
    g.one_round()
end

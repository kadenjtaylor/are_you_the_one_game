require_relative 'util'


YES = "X"
NO = "o"
MAYBE = "."

class DumbPlayer

    def initialize
        @pairs = {}
        @debug = false
        @info_percentages = []
    end

    def d(s)
        if @debug
            puts s
        end
    end

    def info_percentage
        (100.0-pairs_with(MAYBE).size)/100
    end

    def create_guess(males, females, turn_number)
        d "-----------------------------------------------------------------"
        d "Turn #{turn_number}: "
        d "-----------------------------------------------------------------"
        d "Current Knowledge: #{info_percentage}"
        @info_percentages.append(info_percentage)
        print_pairs_grid
        if @pairs.empty?
            populate_all_possible_pairs(males, females)
        end
        d "-----------------------------------------------------------------"
        d "GUESS:"
        d "\t- start_state { Good: #{pairs_with(YES).size}/10, Bad:  #{pairs_with(NO).size}/90 }"
        # puts "\t- Creating guess..."
        possible_guesses = pairs_with(MAYBE)
        d "\t- I found #{possible_guesses.length} pairs I could guess..."
        randy = possible_guesses.sample
        d "\t- Guessing: #{print_pair(randy)}"
        randy
    end

    def guess_feedback(pair, is_correct)
        d "\nFEEDBACK:"
        d "\t- Guess was #{is_correct ? "correct!" : "incorrect!"}"
        if is_correct
            mark_cross(pair)
        else
            set_no(pair.male, pair.female)
        end
    end

    def create_lineup(males, females, turn_number)
        d "\nLINEUP:"
        lineup = []
        ms = Array.new(males)
        fs = Array.new(females)

        # switch from explore to exploit eventually
        if turn_number > 15
            good_pairs = pairs_with(YES)
            d "\t- I'm picking my #{good_pairs.size} known pairs"
            good_pairs.each do |p|
                lineup.append(p)
                ms.delete(p.male)
                fs.delete(p.female)
            end
        end

        # Random guesses on the others
        randoms = random_pairings(ms, fs)
        d "\t- I'm adding #{randoms.size} random ones"
        randoms.each do |p|
            lineup.append(p)
        end
        lineup
    end

    def lineup_feedback(lineup, num_correct)
        d "\nFEEDBACK:"
        d "\t- I got #{num_correct} right!"

        if num_correct == 0
            d "\t- Since none were correct, I can mark them all NO"
            lineup.each do |p|
                set_no(p.male, p.female)
            end
        end
        # TODO: store some info that'll be helpful
    end

    def populate_all_possible_pairs(males, females)
        count = 0
        for m in males
            for f in females
                if @pairs[m].nil?
                    @pairs[m] = {}
                end
                count += 1
                @pairs[m][f] = MAYBE
                # puts "(#{m} + #{f}): #{@pairs[m][f]}"
            end
        end
        d "Created #{count} pairs"
    end

    def pairs_with(value)
        ret_list = []
        for m in @pairs.keys
            for f in @pairs[m].keys
                ret_list.append(
                    OpenStruct.new(
                        :male => m,
                        :female => f
                    )
                ) if @pairs[m][f] == value
            end
        end
        ret_list
    end

    def mark_cross(pair)
        set_yes(pair.male, pair.female)
        @pairs[pair.male].keys.each do |k|
            set_no(pair.male, k)
        end
        
        @pairs.keys.each do |k|
            set_no(k, pair.female)
        end
    end

    def set_no(male, female)
        if @pairs[male][female] == MAYBE
            @pairs[male][female] = NO
            d "\t\t- (#{male} + #{female}) set to NO"
        elsif @pairs[male][female] == NO
            d "\t\t- (#{male} + #{female}) was already NO"
        else
            # d "(Tried to go YES -> NO)"
        end
    end

    def set_yes(male, female)
        if @pairs[male][female] == MAYBE
            @pairs[male][female] = YES
            d "\t\t- (#{male} + #{female}) set to YES"
        elsif @pairs[male][female] == YES
            d "\t\t- (#{male} + #{female}) was already YES"
        else
            d "(Tried to go NO -> YES)"
        end
    end

    def set_maybe(male, female)
        @pairs[male][female] = MAYBE
    end

    def print_pairs_grid
        ret_list = "\n\t"
        for m in @pairs.keys
            for f in @pairs[m].keys
                ret_list += " #{@pairs[m][f]} "
            end
            ret_list += "\n\t"
        end
        d ret_list
    end

    def dump_data
        @info_percentages
    end

end

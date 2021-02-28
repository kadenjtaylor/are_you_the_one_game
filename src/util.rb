def random_pairings(males, females)
    ms = Array.new(males)
    fs = Array.new(females)
    pairs = Array.new
    while !ms.empty? # just run it until we run out of males

        # randomly grab one male and one female
        m = ms.sample
        f = fs.sample

        # remove them so we can't pick them twice
        ms.delete(m)
        fs.delete(f)

        # create a pair out of them
        pairs.append(
            OpenStruct.new(
            :male => m,
            :female => f
        ))
    end
    pairs
end

def random_pair(males, females)
    # randomly grab one male and one female
    m = males.sample
    f = females.sample

    # create a pair out of them
    OpenStruct.new(
        :male => m,
        :female => f
    )
end

def print_pair(p)
    "(#{p.male} + #{p.female})"
end
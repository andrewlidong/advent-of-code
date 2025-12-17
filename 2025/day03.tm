# Advent of Code 2025 - Day 3: Lobby
# https://adventofcode.com/2025/day/3

func max_joltage_for_bank(bank:Text -> Int)
    # Greedy approach: try from highest to lowest first digit
    # then find the best second digit that comes after it
    length := bank.length

    # Try first digits from 9 down to 1
    d1 := 9
    while d1 >= 1
        d1_str := Text(d1)

        # Find all positions where d1 appears
        pos := 1
        while pos <= length
            if bank.from(pos).to(1) == d1_str
                # Found d1 at position pos, now find best d2 after it
                # Try from 9 down to 1
                d2 := 9
                while d2 >= 1
                    d2_str := Text(d2)
                    # Check if d2 appears after position pos
                    search_pos := pos + 1
                    while search_pos <= length
                        if bank.from(search_pos).to(1) == d2_str
                            # Found the pair!
                            return d1 * 10 + d2
                        search_pos += 1
                    d2 -= 1
            pos += 1

        d1 -= 1

    return 0

func part1(input:Text -> Int)
    lines := input.split("\n")
    total := 0

    for line in lines
        if line != ""
            max_jolts := max_joltage_for_bank(line)
            total += max_jolts

    return total

func main()
    # Test with example
    example := "987654321111111\n811111111111119\n234234234234278\n818181911112111"

    say("=== Testing with example ===")
    example_result := part1(example)
    say("Part 1 result: $example_result (expected: 357)")
    say("")

    # Read actual input file
    input_path := (./2025/input3.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        result := part1(input)
        say("Part 1: $result")
    else
        say("No input3.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/3/input")

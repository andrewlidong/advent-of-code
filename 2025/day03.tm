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

func max_k_digit_number(bank:Text, k:Int -> Text)
    # Greedy algorithm to select k digits that form the maximum k-digit number
    # At each position, pick the largest digit from the valid range
    length := bank.length
    result := ""
    start_pos := 1

    i := 0
    while i < k
        remaining := k - i
        # Can pick from start_pos to (length - remaining + 1)
        end_pos := length - remaining + 1

        # Find the maximum digit in range [start_pos, end_pos]
        max_digit := "0"
        max_pos := start_pos

        pos := start_pos
        while pos <= end_pos
            digit := bank.from(pos).to(1)
            if digit > max_digit
                max_digit = digit
                max_pos = pos
            pos += 1

        # Add the max digit to result
        result = "$result$max_digit"
        start_pos = max_pos + 1
        i += 1

    return result

func part1(input:Text -> Int)
    lines := input.split("\n")
    total := 0

    for line in lines
        if line != ""
            max_jolts := max_joltage_for_bank(line)
            total += max_jolts

    return total

func part2(input:Text -> Int)
    lines := input.split("\n")
    total := 0

    for line in lines
        if line != ""
            # Get the 12-digit maximum as a text string
            max_str := max_k_digit_number(line, 12)
            # Parse it as an Int and add to total
            if jolts := Int.parse(max_str)
                total += jolts

    return total

func main()
    # Test with example
    example := "987654321111111\n811111111111119\n234234234234278\n818181911112111"

    say("=== Testing with example ===")
    say("Part 1:")
    example_result := part1(example)
    say("Result: $example_result (expected: 357)")
    say("")
    say("Part 2:")
    example_result2 := part2(example)
    say("Result: $example_result2 (expected: 3121910778619)")
    say("")

    # Read actual input file
    input_path := (./2025/input3.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        say("Part 1: $(part1(input))")
        say("Part 2: $(part2(input))")
    else
        say("No input3.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/3/input")

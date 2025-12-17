# Advent of Code 2025 - Day 1: Secret Entrance
# https://adventofcode.com/2025/day/1

func rotate_dial(current:Int, direction:Text, distance:Int -> Int)
    # Calculate new position based on direction
    new_pos := 0
    if direction == "L"
        new_pos = current - distance
    else if direction == "R"
        new_pos = current + distance
    else
        new_pos = current

    # Handle wrapping (dial is 0-99)
    # Modulo to wrap around the circular dial
    wrapped := new_pos mod 100

    # Handle negative wrapping
    if wrapped < 0
        wrapped = wrapped + 100

    return wrapped

func part1(input:Text -> Int)
    lines := input.split("\n")

    position := 50  # Start at 50
    zero_count := 0

    say("Starting at position: $position")

    for line in lines
        if line == ""
            skip
        else
            direction := line.to(1)
            distance_str := line.from(2)
            if dist := Int.parse(distance_str)
                position = rotate_dial(position, direction, dist)
                say("After $direction$dist: position = $position")

                if position == 0
                    zero_count += 1
                    say("  -> Hit 0! (count: $zero_count)")

    return zero_count

func part2(input:Text -> Int)
    # Part 2 not yet available
    return 0

func main()
    # Test with example
    example := "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"

    say("=== Testing with example ===")
    example_result := part1(example)
    say("")
    say("Example result: $example_result (expected: 3)")
    say("")

    # Read actual input file
    input_path := (./2025/input.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        result := part1(input)
        say("")
        say("Part 1: $result")
        say("Part 2: $(part2(input))")
    else
        say("No input.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/1/input")

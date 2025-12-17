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

func count_zero_crossings(current:Int, direction:Text, distance:Int -> Int)
    # Count how many times we pass through 0 during the rotation
    # We take 'distance' steps and count how many land on 0

    if direction == "R"
        # Right rotation: count multiples of 100 in range [current+1, current+distance]
        # Number of times we cross 0 = floor((current + distance) / 100)
        return (current + distance) / 100
    else if direction == "L"
        # Left rotation: going backwards from current
        # We land on 0 at steps where (current - k) mod 100 = 0
        # This means k = current, current+100, current+200, ...
        # Special case: if current = 0, we don't count the first step (we start at 0)
        if current == 0
            # First crossing is at step 100, then 200, etc.
            return distance / 100
        else if distance >= current
            # We cross 0 at step 'current', then 'current+100', etc.
            return (distance - current) / 100 + 1
        else
            # distance < current, we never reach 0
            return 0
    else
        return 0

func part2(input:Text -> Int)
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
                # Count all times we pass through 0 during the rotation
                crossings := count_zero_crossings(position, direction, dist)

                position = rotate_dial(position, direction, dist)
                say("After $direction$dist: position = $position, crossed 0 $crossings time(s)")

                zero_count += crossings

    return zero_count

func main()
    # Test with example
    example := "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"

    say("=== Testing with example ===")
    say("Part 1:")
    example_result := part1(example)
    say("")
    say("Part 1 result: $example_result (expected: 3)")
    say("")
    say("Part 2:")
    example_result2 := part2(example)
    say("")
    say("Part 2 result: $example_result2 (expected: 6)")
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

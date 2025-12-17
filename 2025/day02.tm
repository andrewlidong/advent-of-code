# Advent of Code 2025 - Day 2: Gift Shop
# https://adventofcode.com/2025/day/2

struct Range(start:Int, end:Int)

func is_invalid_id(n:Int -> Bool)
    # An invalid ID is a digit sequence repeated exactly twice
    # e.g., 11, 6464, 123123
    # No leading zeros allowed

    s := Text(n)
    length := s.length

    # Must have even length to split in half
    if length mod 2 != 0
        return no

    half_len := length / 2
    first_half := s.to(half_len)
    second_half := s.from(half_len + 1)

    # Check if both halves are equal
    if first_half != second_half
        return no

    # Check for leading zeros (first character of first half must not be '0')
    if first_half.to(1) == "0"
        return no

    return yes

func parse_range(range_str:Text -> Range)
    # Remove any trailing newlines or whitespace
    clean_str := range_str
    # Remove trailing newline if present
    if clean_str.from(clean_str.length).to(1) == "\n"
        clean_str = clean_str.to(clean_str.length - 1)

    parts := clean_str.split("-")
    start := Int.parse(parts[1]!) or 0
    end := Int.parse(parts[2]!) or 0
    return Range(start, end)

func count_invalid_in_range(start:Int, end:Int -> Int)
    total := 0

    n := start
    while n <= end
        if is_invalid_id(n)
            total += n
        n += 1

    return total

func part1(input:Text -> Int)
    # Parse comma-separated ranges
    ranges_str := input.split(",")

    total_sum := 0

    for range_str in ranges_str
        # Skip empty strings
        if range_str == "" or range_str == "\n"
            skip
        else
            range := parse_range(range_str)
            range_sum := count_invalid_in_range(range.start, range.end)
            total_sum += range_sum

    return total_sum

func is_invalid_id_part2(n:Int -> Bool)
    # Match Python implementation exactly
    s := Text(n)
    len_n := s.length

    # Part 1 check: split in half
    if len_n mod 2 == 0
        half := len_n / 2
        s1 := s.to(half)
        s2 := s.from(half + 1)
        if s1 == s2
            return yes

    # Part 2 check: any repeating pattern
    i := 1
    while i <= len_n / 2
        if len_n mod i == 0
            substring := s.to(i)
            # Check if repeating this substring gives us the original string
            match := yes
            pos := 1
            while pos <= len_n
                substring_pos := ((pos - 1) mod i) + 1
                if s.from(pos).to(1) != substring.from(substring_pos).to(1)
                    match = no
                    stop
                pos += 1
            if match
                return yes
        i += 1

    return no

func part2(input:Text -> Int)
    ranges_str := input.split(",")
    total_sum := 0

    for range_str in ranges_str
        if range_str == "" or range_str == "\n"
            skip
        else
            range := parse_range(range_str)

            n := range.start
            while n <= range.end
                if is_invalid_id_part2(n)
                    total_sum += n
                n += 1

    return total_sum

func main()
    # Test with example
    example := "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

    say("=== Testing with example ===")
    say("Part 1:")
    example_result := part1(example)
    say("")
    say("Part 1 result: $example_result (expected: 1227775554)")
    say("")
    say("Part 2:")
    example_result2 := part2(example)
    say("")
    say("Part 2 result: $example_result2 (expected: 4174379265)")
    say("")

    # Read actual input file
    input_path := (./2025/input2.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        result := part1(input)
        say("")
        say("Part 1: $result")
        say("Part 2: $(part2(input))")
    else
        say("No input2.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/2/input")

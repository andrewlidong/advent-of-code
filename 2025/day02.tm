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
    parts := range_str.split("-")
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
            say("Range $(range.start)-$(range.end): sum = $range_sum")
            total_sum += range_sum

    return total_sum

func part2(input:Text -> Int)
    # Part 2 not yet available
    return 0

func main()
    # Test with example
    example := "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

    say("=== Testing with example ===")
    example_result := part1(example)
    say("")
    say("Part 1 result: $example_result (expected: 1227775554)")
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

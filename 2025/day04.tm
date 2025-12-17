# Advent of Code 2025 - Day 4: Printing Department
# https://adventofcode.com/2025/day/4

func part1(input:Text -> Int)
    lines := input.split("\n")

    # Count non-empty lines to get grid size
    rows := 0
    for line in lines
        if line != ""
            rows += 1

    if rows == 0
        return 0

    # Get the grid as an array (lines already contains it)
    accessible := 0
    line_idx := 0
    row := 0

    for line in lines
        if line != ""
            if row == 0
                # Get cols from first line
                cols := line.length

            col := 0
            while col < line.length
                cell := line.from(col + 1).to(1)
                if cell == "@"
                    # Count adjacent rolls
                    adjacent_count := 0

                    dr := -1
                    while dr <= 1
                        dc := -1
                        while dc <= 1
                            if dr != 0 or dc != 0
                                new_row := row + dr
                                new_col := col + dc

                                if new_row >= 0 and new_row < rows and new_col >= 0 and new_col < line.length
                                    # Find the line at new_row
                                    target_line_idx := 0
                                    target_row := 0
                                    for target_line in lines
                                        if target_line != ""
                                            if target_row == new_row
                                                target_cell := target_line.from(new_col + 1).to(1)
                                                if target_cell == "@"
                                                    adjacent_count += 1
                                                stop
                                            target_row += 1
                            dc += 1
                        dr += 1

                    if adjacent_count < 4
                        accessible += 1
                col += 1
            row += 1

    return accessible

func main()
    # Test with example
    example := "..@@.@@@@.\n@@@.@.@.@@\n@@@@@.@.@@\n@.@@@@..@.\n@@.@@@@.@@\n.@@@@@@@.@\n.@.@.@.@@@\n@.@@@.@@@@\n.@@@@@@@@.\n@.@.@@@.@."

    say("=== Testing with example ===")
    example_result := part1(example)
    say("Part 1: $example_result (expected: 13)")
    say("")

    # Read actual input file
    input_path := (./2025/input4.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        say("Part 1: $(part1(input))")
    else
        say("No input4.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/4/input")

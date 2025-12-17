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

func part2(input:Text -> Int)
    # Convert grid to a mutable single string with known dimensions
    lines := input.split("\n")

    # Get dimensions
    rows := 0
    cols := 0
    for line in lines
        if line != ""
            rows += 1
            if cols == 0
                cols = line.length

    if rows == 0
        return 0

    # Build grid as a single mutable string
    grid_str := ""
    for line in lines
        if line != ""
            grid_str = "$grid_str$line"

    total_removed := 0

    # Keep removing accessible rolls until none remain
    while yes
        # Find all accessible positions
        accessible_count := 0
        to_remove := ""  # Will be a string of 'y' or 'n' for each position

        pos := 0
        while pos < grid_str.length
            row := pos / cols
            col := pos mod cols
            cell := grid_str.from(pos + 1).to(1)

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

                            if new_row >= 0 and new_row < rows and new_col >= 0 and new_col < cols
                                target_pos := new_row * cols + new_col
                                target_cell := grid_str.from(target_pos + 1).to(1)
                                if target_cell == "@"
                                    adjacent_count += 1
                        dc += 1
                    dr += 1

                if adjacent_count < 4
                    to_remove = "$(to_remove)y"
                    accessible_count += 1
                else
                    to_remove = "$(to_remove)n"
            else
                to_remove = "$(to_remove)n"

            pos += 1

        # If no accessible positions, we're done
        if accessible_count == 0
            stop

        # Remove all accessible positions
        new_grid := ""
        pos = 0
        while pos < grid_str.length
            should_remove := to_remove.from(pos + 1).to(1)
            if should_remove == "y"
                new_grid = "$new_grid."
            else
                char := grid_str.from(pos + 1).to(1)
                new_grid = "$new_grid$char"
            pos += 1

        grid_str = new_grid
        total_removed += accessible_count

    return total_removed

func main()
    # Test with example
    example := "..@@.@@@@.\n@@@.@.@.@@\n@@@@@.@.@@\n@.@@@@..@.\n@@.@@@@.@@\n.@@@@@@@.@\n.@.@.@.@@@\n@.@@@.@@@@\n.@@@@@@@@.\n@.@.@@@.@."

    say("=== Testing with example ===")
    say("Part 1: $(part1(example)) (expected: 13)")
    say("Part 2: $(part2(example)) (expected: 43)")
    say("")

    # Read actual input file
    input_path := (./2025/input4.txt)
    if input_path.exists()
        say("=== Running with actual input ===")
        input := input_path.read()!
        say("Part 1: $(part1(input))")
        say("Part 2: $(part2(input))")
    else
        say("No input4.txt found. Download your input from:")
        say("https://adventofcode.com/2025/day/4/input")

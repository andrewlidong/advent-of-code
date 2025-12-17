# Common utility functions for Advent of Code

# Split text into lines
func lines(text:Text -> [Text])
    text.split("\n")

# Parse a line of space-separated integers
func parse_ints(line:Text -> [Int])
    parts := line.split(" ")
    result : [Int] = []
    for part in parts
        if parsed := Int.parse(part)
            result = result + [parsed]
    result

# Grid/2D array helpers
struct Point(x:Int, y:Int)
    func add(a:Point, b:Point -> Point)
        Point(a.x + b.x, a.y + b.y)

# Common directions for grid problems
_UP := Point(0, -1)
_DOWN := Point(0, 1)
_LEFT := Point(-1, 0)
_RIGHT := Point(1, 0)
_DIRECTIONS := [_UP, _DOWN, _LEFT, _RIGHT]

# Check if point is in bounds
func in_bounds(p:Point, width:Int, height:Int -> Bool)
    p.x >= 0 and p.x < width and p.y >= 0 and p.y < height

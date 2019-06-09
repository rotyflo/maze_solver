class MazeSolver
  attr_writer :maze

  def initialize
    @file = ARGV[0]
    @maze = File.open(@file).map(&:chomp)
    @starting_point = nil
    @ending_point = nil
    @visited_points = []
  end

  def solve
    find_start_and_end
    start_at_beginning
    
    while !solved?
      render
      wander
    end

    puts "Solved!"
  end

  def wander
    @visited_points.each do |point|
      sleep(0.1)
      render
      y, x = point

      if up(point) == " "
        point = [y - 1, x]
        @visited_points << point
        @maze[y - 1][x] = "X"
      elsif right(point) == " "
        point = [y, x + 1]
        @visited_points << point
        @maze[y][x + 1] = "X"
      elsif down(point) == " "
        point = [y + 1, x]
        @visited_points << point
        @maze[y + 1][x] = "X"
      elsif left(point) == " "
        point = [y, x - 1]
        @visited_points << point
        @maze[y][x - 1] = "X"
      end
    end
  end

  def up(pos)
    y, x = pos

    @maze[y - 1][x]
  end

  def down(pos)
    y, x = pos

    @maze[y + 1][x]
  end

  def left(pos)
    y, x = pos

    @maze[y][x - 1]
  end

  def right(pos)
    y, x = pos

    @maze[y][x + 1]
  end

  def render
    system("clear")
    puts @maze
  end

  def solved?
    y, x = @ending_point

    @maze[y + 1][x] == "X" || @maze[y - 1][x] == "X" || @maze[y][x + 1] == "X" || @maze[y][x - 1] == "X"
  end

  def find_start_and_end
    @maze.each_with_index do |string, index|
      @starting_point = [index, string.index("S")] if string.index("S")
      @ending_point = [index, string.index("E")] if string.index("E")
    end
  end

  def start_at_beginning
    @visited_points << @starting_point
  end
end

maze_solver = MazeSolver.new
maze_solver.solve
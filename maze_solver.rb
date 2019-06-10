class MazeSolver
  def initialize
    @file = ARGV[0]
    @maze = File.open(@file).map(&:chomp)
    @starting_point = nil
    @ending_point = nil
    @visited_points = []
    @footprints = "."
    @time_between_steps = 0.05
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
    @visited_points.each do |pos|
      sleep(@time_between_steps)
      render

      if can_walk_up_from?(*pos)
        move_up_from(*pos)
      elsif can_walk_right_from?(*pos)
        move_right_from(*pos)
      elsif can_walk_down_from?(*pos)
        walk_down_from(*pos)
      elsif can_walk_left_from?(*pos)
        walk_left_from(*pos)
      end
    end
  end

  def can_walk_up_from?(y, x)
    @maze[y - 1][x] == " "
  end

  def can_walk_down_from?(y, x)
    @maze[y + 1][x] == " "
  end

  def can_walk_left_from?(y, x)
    @maze[y][x - 1] == " "
  end

  def can_walk_right_from?(y, x)
    @maze[y][x + 1] == " "
  end

  def move_up_from(y, x)
    @visited_points << [y - 1, x]
    @maze[y - 1][x] = @footprints
  end

  def move_right_from(y, x)
    @visited_points << [y, x + 1]
    @maze[y][x + 1] = @footprints
  end

  def walk_down_from(y, x)
    @visited_points << [y + 1, x]
    @maze[y + 1][x] = @footprints
  end

  def walk_left_from(y, x)
    @visited_points << [y, x - 1]
    @maze[y][x - 1] = @footprints
  end

  def render
    system("clear")
    puts @maze
  end

  def solved?
    y, x = @ending_point

    @maze[y + 1][x] == @footprints || @maze[y - 1][x] == @footprints || @maze[y][x + 1] == @footprints || @maze[y][x - 1] == @footprints
  end

  def find_start_and_end
    @maze.each_with_index do |string, index|
      y = index

      if string.index("S")
        x = string.index("S")
        @starting_point = [y, x]
      end
      if string.index("E")
        x = string.index("E")
        @ending_point = [y, x]
      end
    end
  end

  def start_at_beginning
    @visited_points << @starting_point
  end
end

maze_solver = MazeSolver.new
maze_solver.solve
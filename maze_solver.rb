class MazeSolver
  def initialize(maze)
    @maze = maze
  end

  def solve
    render
  end

  def render
    File.open(@maze).each_line do |string|
      puts string
    end
  end
end

maze_solver = MazeSolver.new("maze1.txt")
maze_solver.solve
class MazeSolver
  def initialize
    @maze = ARGV[0]
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

maze_solver = MazeSolver.new
maze_solver.solve
require 'tree'
require 'colored'

class MazeSolver

  def initialize(maze_file)
    @maze = parse(maze_file)
    @covered = []
    @depth = 0
    @levels = []
    @visited = []
  end

  def [](row, col)
    @maze[row][col]
  end

  def solve
     @levels << [Node.new(find_start, nil)]
     until end_reached?
       add_level
     end
     print_trace
  end

  def add_level
    @depth += 1
    @levels[@depth] = []
    @levels[@depth - 1].each do |parent|
      add_nodes(parent)
    end
  end


  def add_nodes(parent)
    empty_neighbors(parent).each do |pos|
      if self[*pos] == "E"
        @levels[@depth] << @final_node = Node.new(pos, parent)
      else
        @levels[@depth] << Node.new(pos, parent)
      end
      @visited << pos
    end
  end

  def end_reached?
    !@final_node.nil?
  end

  def trace_to_start(node)
    current_node = node
    path = []
    loop do
      path << current_node.pos
      break if current_node.parent.nil?
      current_node = current_node.parent
    end
    path.pop
    path.shift
    path.reverse
  end

  def draw_trace
    path = trace_to_start(@final_node)
    maze = @maze.dup
    each_coordinate do |row, col|
      maze[row][col] = "x" if path.include?([row, col])
    end
    maze
  end

  def print_trace
    draw_trace.each do |row|
      print_row(row)
      print "\n"
    end
  end

  def print_row(row)
    row.each do |el|
      if el == "*"
        print el
      else
        print el.red
      end
    end
  end

  def find_start
    each_coordinate { |row, col| return [row, col] if self[row, col] == "S" }
  end

  def each_coordinate
    (0...@maze.length).each do |row|
      (0...@maze[0].length).each do |col|
        yield(row, col)
      end
    end
  end

  def neighbors(pos)
    [
      [pos[0] + 1, pos[1]],
      [pos[0] - 1, pos[1]],
      [pos[0], pos[1] + 1],
      [pos[0], pos[1] - 1],
      [pos[0] + 1, pos[1] + 1],
      [pos[0] - 1, pos[1] - 1],
      [pos[0] + 1, pos[1] - 1],
      [pos[0] - 1, pos[1] + 1],
    ]
    # neighbors = []
    # each_coordinate do |row, col|
    #   if (row - pos[0]).abs < 2 && (col - pos[1]).abs < 2
    #     neighbors << [row, col]
    #   end
    # end
    # neighbors
  end

  def empty_neighbors(node)
    neighbors(node.pos).select do |pos|
      correct_value = self[*pos] == " " || self[*pos] == "E"
      not_visited = !@visited.include?(pos)
      correct_value && not_visited
    end
  end

  def parse(maze_file)
    File.readlines(maze_file).map(&:chomp).map { |row| row.split("") }
  end

end

class Node < Struct.new(:pos, :parent)
end

maze = MazeSolver.new("hard-maze.txt")

maze.solve

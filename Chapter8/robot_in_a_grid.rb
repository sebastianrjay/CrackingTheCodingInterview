# Imagine a robot sitting on the upper left corner of grid with r rows and c 
# columns. The robot can only move in two directions, right and down, but 
# certain cells are "off limits" such that the robot cannot step on them. Design 
# an algorithm to find a path for the robot from the top left to the bottom 
# right.

require 'set'

class Cell
  OFF_LIMITS_PROBABILITY_PERCENTAGE = 20
  attr_reader :off_limits
  def initialize
    @off_limits = ((100 * rand).to_i <= OFF_LIMITS_PROBABILITY_PERCENTAGE)
  end
end

r, c = 8, 6
matrix = (1..r).map { (1..c).map { Cell.new } }

def get_cell(matrix, coords)
  matrix[coords[0]][coords[1]]
end

def in_bounds?(matrix, coords)
  coords[0] >= 0 && coords[0] < matrix.length &&
    coords[1] >= 0 && coords[1] < matrix[0].length
end

def next_coords(matrix, current_coords, visited_coords)
  downward_coords = [current_coords[0] + 1, current_coords[1]]
  rightward_coords = [current_coords[0], current_coords[1] + 1]

  [downward_coords, rightward_coords].find do |coords|
    in_bounds?(matrix, coords) && !get_cell(matrix, coords).off_limits &&
      !visited_coords.include?(coords)
  end
end

# Worst case O(m * n) time and O(m * n) space
def get_valid_path_iteratively(matrix)
  return nil if !matrix || matrix.length == 0 || matrix[0].length == 0
  current_path_array, current_path_set, visited_coords = [], Set.new, Set.new
  current_coords, final_coords = [0, 0], [matrix.length - 1, matrix[0].length - 1]
  return nil if get_cell(matrix, current_coords).off_limits
  current_path_array << current_coords
  current_path_set << current_coords

  until current_coords == final_coords || current_path_array.empty?
    next_coords = next_coords(matrix, current_coords, visited_coords)

    if next_coords
      [current_coords, next_coords].each do |coords|
        unless current_path_set.include?(coords)
          current_path_set << coords
          visited_coords << coords
          current_path_array << coords
        end
      end
      current_coords = next_coords
    else
      current_coords = current_path_array.pop
      current_path_set.delete(current_coords)
    end
  end

  current_path_array.empty? ? nil : current_path_array
end

def get_recursive_path(matrix, row, col, path, cache)
  if col < 0 || row < 0 || matrix[row][col].off_limits
    return false
  end

  return cache[[row, col]] if cache[[row, col]]

  is_at_origin, success = (row == 0 && col == 0), false
  if is_at_origin || get_recursive_path(matrix, row, col - 1, path, cache) ||
      get_recursive_path(matrix, row - 1, col, path, cache)
    path << [row, col]
    success = true
  end

  cache[[row, col]] = success
  success
end

# Worst case O(m * n) time and O((m + n) choose n) space
def get_valid_path_recursively(matrix)
  return nil if matrix.nil? || matrix.length == 0 || matrix[0].length == 0

  path, cache = [], {}
  last_row, last_col = matrix.length - 1, matrix[0].length - 1

  if get_recursive_path(matrix, last_row, last_col, path, cache)
    return path
  end

  nil
end

puts "matrix:"
puts "["
matrix.each {|row| p row.map(&:off_limits) }
puts "]"
p get_valid_path_iteratively(matrix)
p get_valid_path_recursively(matrix)

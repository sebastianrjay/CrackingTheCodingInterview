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

def next_coord_pairs(matrix, current_coords)
  downward_coords = [current_coords[0] + 1, current_coords[1]]
  rightward_coords = [current_coords[0], current_coords[1] + 1]

  [downward_coords, rightward_coords].select {|coords| in_bounds?(matrix, coords)}
end

def get_valid_path(matrix)
  return nil if matrix.length < 1 || matrix[0].length < 1
  if matrix.length == 1 && matrix[0].length == 1
    return [[0, 0]] unless get_cell(matrix, [0, 0]).off_limits
    return nil
  end
  current_path_array, off_limits_coords, visited_coords = [], Set.new, Set.new
  current_coords, final_coords = [0, 0], [matrix.length - 1, matrix[0].length - 1]
  current_path_set = Set.new
  current_path_array << current_coords
  current_path_set << current_coords

  until current_coords == final_coords || current_path_array.empty?
    next_coords = next_coord_pairs(matrix, current_coords)
    next_coords.each do |coords|
      off_limits_coords << coords if get_cell(matrix, coords).off_limits
    end

    new_coords = next_coords.find do |coords|
      !off_limits_coords.include?(coords) && !visited_coords.include?(coords)
    end

    if new_coords
      [current_coords, new_coords].each do |coords|
        unless current_path_set.include?(coords)
          current_path_set << coords
          visited_coords << coords
          current_path_array << coords
        end
      end
      current_coords = new_coords
    else
      current_coords = current_path_array.pop
      current_path_set.delete(current_coords)
    end
  end

  current_path_array.empty? ? nil : current_path_array
end

puts "matrix:"
puts "["
matrix.each {|row| p row.map(&:off_limits) }
puts "]"
p get_valid_path(matrix)

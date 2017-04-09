# Write an algorithm to generate all subsets of an array.

def iterative_power_set(array)
  sets = [[]]

  array.each do |el|
    new_sets = sets.map {|set| set + [el]}
    sets += new_sets
  end

  sets
end

def recursive_power_set(array, sets = [[]])
  return sets if array.empty?

  last_el = array.pop
  new_sets = sets.map {|set| set + [last_el]}
  sets += new_sets
  recursive_power_set(array, sets)
end

p iterative_power_set(['a', 'b', 'c', 'd'])
p recursive_power_set(['a', 'b', 'c', 'd'])

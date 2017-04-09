# A magic index in an array A[0...n - 1] is defined to be an index such that 
# A[i] = i. Given a sorted array of distinct integers, write a method to find a 
# magic index, if one exists, in array A.

# Runs in O(log(n)) time and O(log(n)) space
def magic_index(sorted_array, start_idx = nil, end_idx = nil)
  return nil if sorted_array.empty?
  start_idx ||= 0
  end_idx ||= sorted_array.length - 1
  middle_idx = (start_idx + end_idx) / 2

  return middle_idx if sorted_array[middle_idx] == middle_idx
  return nil if start_idx && end_idx && start_idx == end_idx

  if sorted_array[middle_idx] < middle_idx
    magic_index(sorted_array, start_idx, middle_idx - 1)
  else
    magic_index(sorted_array, middle_idx + 1, end_idx)
  end
end

p magic_index([1, 3, 5, 6, 6, 6, 6, 7, 8, 9])
p magic_index([1, 2, 3, 4, 5, 5, 5, 8, 10])
p magic_index([0, 1, 2, 3, 4, 5, 6])
p magic_index([0, 1, 2, 3, 4, 5])
p magic_index([2, 3, 5])
p magic_index([2])
